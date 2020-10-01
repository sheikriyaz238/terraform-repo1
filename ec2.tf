module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "ec2secgrp"
  description = "Security group for usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "web server"
      cidr_blocks = "0.0.0.0/0"
    },
	{
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules        = ["all-all"]
}

module "jvm-ec2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "ec2-java"
  instance_count         = 1

  ami                    = "ami-0a669382ea0feb73a"
  instance_type          = "t2.micro"
  key_name               = "booghekp"
  monitoring             = false
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.security_group.this_security_group_id]
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

