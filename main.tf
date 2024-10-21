#	Set Provider / Region
provider "aws" {
	region = var.region_name
}


#	Create and save SSH key and PEM file in local storage while running
resource "tls_private_key" "tf_ssh_key" {
	algorithm = "RSA"
}

resource "aws_key_pair" "tf_generated_key_pair" {
	key_name = "tf-ssh-key"
	public_key = tls_private_key.tf_ssh_key.public_key_openssh
	depends_on = [
		tls_private_key.tf_ssh_key
	]
}

resource "local_file" "tf_key_file" {
	content = tls_private_key.tf_ssh_key.private_key_pem
	filename = "tf-ssh-key.pem"
	file_permission = "0400"
	depends_on = [
		tls_private_key.tf_ssh_key
	]
}


#	Set data for template file
data "template_file" "instance_setup" {
	template = file("instance_setup.sh")
}


#	Create an Elasticv IP (EIP)
resource "aws_eip" "tf_eip" {
	instance = aws_instance.tf_instance.id
}


#	Create an instance to hold the docker container
resource "aws_instance" "tf_instance" {
	ami = var.ami_id
	instance_type = var.instance_type
	
	#	Configure SSH key pair
	key_name = aws_key_pair.tf_generated_key_pair.key_name
	
	#	Set Subnet / VPC
	subnet_id = var.subnet_id
	vpc_security_group_ids = var.desired_security_group_ids
	associate_public_ip_address = true

	tags = {
		Name = var.instance_name
	}

	#	Set storage
	root_block_device {
		volume_size = var.ec2_block_volume_size
		volume_type = var.ec2_block_volume_type
		delete_on_termination = true
	}
	
	#	Set user data to do initial installations
	user_data = file("instance_setup.sh")
}	


#	Output the public IP, DNS name, and SSH command to connect to the EC2 instance
output "instance_details" {
  value = {
    public_ip    = aws_instance.tf_instance.public_ip
    access_url   = "http://${aws_instance.tf_instance.public_dns}:${url_connection_port_number}"
    ssh_command  = "ssh -i ${local_file.tf_key_file.filename} ubuntu@${aws_instance.tf_instance.public_dns}"
  }
  description = "Details of the EC2 instance created"
  depends_on  = [aws_eip.tf_eip, aws_instance.tf_instance]
}
