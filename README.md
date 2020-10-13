About

  This Terraform script creates the following infrastructure on AWS Account:
      VPC
      Private Subnets
      Public Subnets
      Internet Gateways
      Bastion Host
      EC2 Instances for Java Application
      Aurora Postgresql Database - Write and Read


Usage:

From the machine where these terraform scripts are worked on, execute the 
following steps:

Step 1:
Replace the "access_key" and "secret_key" in the following file with a valid  
ones from the account which you want to use for creating the infrastructure.

File: provider.tf
 
Step 2:
Open EC2 Dashboard, click on key pairs, click on Create Key Pair.
In the form, enter the name as "booghekp" and leave the file type as "ppk"
Click create. Download a copy in the local for future connections to the 
generated EC2 instances

Step 3:
From the location where you download all these terraform scripts, run the following commands:

terraform init

terraform plan

terraform apply
