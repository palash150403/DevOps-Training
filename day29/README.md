# Day 28 Task

**Project: Deploying a Multi-Tier Architecture Application on AWS using Terraform**

### Project Objective:
This project will assess your ability to deploy a multi-tier architecture application on AWS using Terraform. The deployment will involve using Terraform variables, outputs, and change sets. The multi-tier architecture will include an EC2 instance, an RDS MySQL DB instance, and an S3 bucket.

### Project Overview:
You are required to write Terraform configuration files to automate the deployment of a multi-tier application on AWS. The architecture should consist of:
EC2 Instance: A t2.micro instance serving as the application server.
RDS MySQL DB Instance: A t3.micro instance for the database backend.
S3 Bucket: For storing static assets or configuration files.
### Specifications:
EC2 Instance: Use the t2.micro instance type with a public IP, allowing HTTP and SSH access.
RDS MySQL DB Instance: Use the t3.micro instance type with a publicly accessible endpoint.
S3 Bucket: Use for storing static assets, configuration files, or backups.
Terraform Configuration:
Utilize Terraform variables to parameterize the deployment (e.g., instance type, database name).
Use Terraform outputs to display important information (e.g., EC2 public IP, RDS endpoint).
Implement change sets to demonstrate how Terraform manages infrastructure changes.
No Terraform Modules: Focus solely on the core Terraform configurations without custom or external modules.

 - Key Tasks:
     - Provider Configuration:
Configure the AWS provider to specify the region for deployment.
Ensure the region is parameterized using a Terraform variable.
VPC and Security Groups:
Create a VPC with a public subnet for the EC2 instance.
Define security groups allowing HTTP and SSH access to the EC2 instance, and MySQL access to the RDS instance.

     - EC2 Instance:
Define the EC2 instance using a t2.micro instance type.
Configure the instance to allow SSH and HTTP access.
Use Terraform variables to define instance parameters like AMI ID and instance type.

     - RDS MySQL DB Instance:
Create a t3.micro MySQL DB instance within the same VPC.
Use Terraform variables to define DB parameters like DB name, username, and password.
Ensure the DB instance is publicly accessible, and configure security groups to allow access from the EC2 instance.

     - S3 Bucket:
Create an S3 bucket for storing static files or configurations.
Allow the EC2 instance to access the S3 bucket by assigning the appropriate IAM role and policy.

     - Outputs:
Define Terraform outputs to display the EC2 instance’s public IP address, the RDS instance’s endpoint, and the S3 bucket name.

 - Apply and Manage Infrastructure:

 - Testing and Validation:
Accessing the EC2 instance via SSH and HTTP.
Connecting to the MySQL DB instance from the EC2 instance.
Verifying that the EC2 instance can read and write to the S3 bucket.
Check the Terraform outputs to ensure they correctly display the relevant information.
Resource Termination:
Once the deployment is complete and validated, run terraform destroy to tear down all the resources created by Terraform.
Confirm that all AWS resources (EC2 instance, RDS DB, S3 bucket, VPC) are properly deleted.

![alt text](<Screenshot from 2024-08-21 17-30-52.png>)

![alt text](<Screenshot from 2024-08-21 18-10-06.png>)

![alt text](<Screenshot from 2024-08-21 17-31-49.png>)

![alt text](<Screenshot from 2024-08-21 17-34-39.png>)

![alt text](<Screenshot from 2024-08-21 17-35-48.png>) 

![alt text](<Screenshot from 2024-08-21 17-36-26.png>) 

![alt text](<Screenshot from 2024-08-21 17-37-11.png>)

![alt text](<Screenshot from 2024-08-21 17-38-30.png>)

![alt text](<Screenshot from 2024-08-21 18-15-15.png>)


### Deliverables:
Terraform Configuration Files: All .tf files used in the deployment.
Deployment Documentation: Detailed documentation covering the setup, deployment, change management, and teardown processes.
Test Results: Evidence of successful deployment and testing, including screenshots or command outputs.
Cleanup Confirmation: Confirmation that all resources have been terminated using terraform destroy.
