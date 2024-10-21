# AWS Terraform Infrastructure Repository


## Index
- [AWS Terraform Infrastructure Repository](#aws-terraform-infrastructure-repository)
  - [Index](#index)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Usage](#usage)



## Overview

This repository contains Terraform configurations to deploy and manage infrastructure on the AWS platform. The infrastructure includes an EC2 instance with Docker containers, and you have the flexibility to customize the region, instance details, and security groups according to your requirements.

## Prerequisites

Before using this Terraform configuration, make sure you have Terraform installed on your machine. You can download and install Terraform from [HashiCorp's official website](https://www.terraform.io/downloads.html).

## Usage

1. Build the desired Docker Images and push them to Docker Hub
2. Clone the repository to your local machine and enter the directory
   ```
   git@github.com:RTLX/terraform_staging_template.git
   ```

3. Adjust the `variables.tf`` file to customize the deployment settings:
   - Adjust the **default** sections of the following variables depeding on the needs of the project:
     - **region_name**
     - **instance_name**
     - **desired_security_group_ids**
     - **ami_id**
     - **instance_type**
     - **subnet_id**
     - **ec2_block_volume_size**
     - **ec2_block_volume_type**
4. Modify the instance_setup.sh script to configure Docker containers. Update the script with the necessary Docker commands, including pulling images from Docker Hub and running containers:
   - Adjust the image name to the desired image
   - Adjust the desired deployment Port 
5. Initialize your Terraform workspace:
   ```
   terraform init
   ```
6. Review the execution plan:
   ```
   terraform plan
   ```
7. Apply the changes to create the infrastructure:
   ```
   terraform apply
   ```
      - After the infrastructure is built, the `.pem` needed to connect via SSH will be save in the directory for connection uses and the terminal will output connection/usage information about the created instance 
8. Destroy the infrastructure when it's no longer needed:
   ```
   terraform destroy
   ```
      - After the infrastructure is destroyed, the `.pem` file created and saved will also be destroyed 

Note:
Ensure that you have Docker installed on your machine before running the Terraform apply. Additionally, make sure the security groups and Docker container configurations align with your project's requirements.

Happy deploying!

