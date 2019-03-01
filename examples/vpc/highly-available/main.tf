module "vpc" {
  source                           = "../../../vpc"
  name                             = "${var.project_name}"
  aws_key_name                     = "${var.project_name}"
  aws_key_location                 = "${file(var.aws_key_location)}"
  nat_instance_count               = "${var.nat_instance_count}"
  database_read_replicas           = "${var.database_read_replicas}"
  database_backup_retention_period = "${var.database_backup_retention_period}"
  database_multi_az                = "${var.database_multi_az}"
  redis_instance_type              = "${var.redis_instance_type}"
  redis_number_cache_clusters      = "${var.redis_number_cache_clusters}"
  redis_automatic_failover_enabled = "${var.redis_automatic_failover_enabled}"
  redis_at_rest_encryption_enabled = "${var.redis_at_rest_encryption_enabled}"
  redis_transit_encryption_enabled = "${var.redis_transit_encryption_enabled}"
}

provider "aws" {
  version = "1.60.0"
}
  
