resource "aws_security_group" "elasticache" {
  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port = "${var.elasticache_port}"
    to_port   = "${var.elasticache_port}"
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
    Name = "${var.name}-elasticache"
  }
}

resource "aws_elasticache_subnet_group" "default" {
  name        = "${var.name}-elasticache-subnet-group"
  description = "Private subnets for the ElastiCache instances"

  subnet_ids = [
    "${module.vpc.elasticache_subnets}",
  ]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.name}-elasticache"
  engine               = "redis"
  engine_version       = "${var.elasticache_engine_version}"
  maintenance_window   = "${var.elasticache_maintenance_window}"
  node_type            = "${var.elasticache_instance_type}"
  num_cache_nodes      = "${var.elasticache_num_cache_nodes}"
  parameter_group_name = "${var.elasticache_parameter_group_name}"
  port                 = "${var.elasticache_port}"
  subnet_group_name    = "${aws_elasticache_subnet_group.default.name}"
  security_group_ids   = ["${aws_security_group.elasticache.id}"]

  tags {
    Name = "${var.name}-redis"
  }
}
