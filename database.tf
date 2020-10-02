module "aurora" {
  source                          = "git::https://github.com/terraform-aws-modules/terraform-aws-rds-aurora.git?ref=master"
  name                            = "aurora-example-postgresql"
  engine                          = "aurora-postgresql"
  engine_version                  = "11.6"
  subnets                         = module.vpc.private_subnets
  vpc_id                          = module.vpc.vpc_id
  replica_count                   = 2
  instance_type                   = "db.r4.large"
  instance_type_replica           = "db.t3.medium"
  apply_immediately               = true
  skip_final_snapshot             = true
  db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgres11_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgres11_parameter_group.id
  //  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  security_group_description = ""
}

resource "aws_db_parameter_group" "aurora_db_postgres11_parameter_group" {
  name        = "dev-aurora-db-postgres11-parameter-group"
  family      = "aurora-postgresql11"
  description = "dev-aurora-db-postgres11-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres11_parameter_group" {
  name        = "dev-aurora-postgres11-cluster-parameter-group"
  family      = "aurora-postgresql11"
  description = "dev-aurora-postgres11-cluster-parameter-group"
}

resource "aws_security_group" "app_servers" {
  name_prefix = "app-servers-"
  description = "For application servers"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "allow_access" {
  type                     = "ingress"
  from_port                = module.aurora.this_rds_cluster_port
  to_port                  = module.aurora.this_rds_cluster_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_servers.id
  security_group_id        = module.aurora.this_security_group_id
}