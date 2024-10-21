#	Define a list of pre-existinng security group IDs
variable "region_name" {
	description = "The name of the availabilty zone that your project will be built on"
	type = string
	default = ""
}

variable "instance_name" {
	description = "The name for the EC2 instance that you wish to be shown on the Instances dashboard"
	type = string
	default = ""
}

variable "desired_security_group_ids" {
	description = "A list of string values for the Security group ID that you wish to be used for the EC2 instance"
	type = list(string)
	default = [""]
}

variable "ami_id" {
	description = "The ID for the desired AMI to be used for the EC2 instance"
	type = string
	default = ""
}

variable "instance_type" {
	description = "The instance type for the EC2 instance that is desired"
	type = string
	default = ""
}

variable "subnet_id" {
	description = "The ID for the desired subnet to be used for the EC2 instance"
	type = string
	default = ""
}

variable "ec2_block_volume_size" {
	description = "The volume of the EC2 block storage in GB "
	type = number
	default = 15
}

variable "ec2_block_volume_type" {
	description = "The volume of the EC2 block storage in GB "
	type = string
	default = "gp2"
}


variable "url_connection_port_number" {
	description = "The port number that is to be used in the url for proper connection"
	type = number
	default = 5555
}