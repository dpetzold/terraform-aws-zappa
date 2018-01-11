resource "random_string" "password" {
  length  = 16
  special = false
}

resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  description = "Database Security Group"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port = "${var.database_port}"
    to_port   = "${var.database_port}"
    protocol  = "tcp"

    security_groups = [
      "${module.vpc.default_security_group_id}",
      "${aws_security_group.bastion.id}",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    security_groups = [
      "${module.vpc.default_security_group_id}",
      "${aws_security_group.bastion.id}",
    ]
  }

  tags {
    Name = "${var.name}-postgres"
  }
}

module "db" {
  source     = "terraform-aws-modules/rds/aws"
  identifier = "posgress-${var.name}"

  engine            = "postgres"
  engine_version    = "9.6.3"
  instance_class    = "${var.database_instance_type}"
  allocated_storage = 5
  storage_encrypted = false

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  name = "db_${var.name}"

  username = "${var.database_username}"
  password = "${random_string.password.result}"
  port     = "${var.database_port}"

  vpc_security_group_ids = ["${aws_security_group.database_sg.id}"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  # DB subnet group
  subnet_ids = ["${module.vpc.database_subnets}"]

  # DB parameter group
  family = "postgres9.6"

  tags {
    Name = "${var.name}-postgres"
  }
}
