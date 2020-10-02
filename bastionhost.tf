module "bastion" {
  source            = "github.com/jetbrains-infra/terraform-aws-bastion-host"
  subnet_id         = module.vpc.public_subnets[0]
  ssh_key           = "booghekp"
  internal_networks = ["10.0.101.0/24"]
  allowed_hosts     = ["0.0.0.0/0"]
  instance_type     = "t2.micro"
  project           = "booghe"
}