output "lambda_subnet_ids" {
  value = "${module.vpc.lambda_subnet_ids}"
}

output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "postgres_endpoint" {
  value = "${module.vpc.postgres_endpoint}"
}

output "postgres_username" {
  value = "${module.vpc.postgres_username}"
}

output "postgres_password" {
  value = "${module.vpc.postgres_password}"
}

output "redis_endpoint" {
  value = "${module.vpc.redis_endpoint}"
}

output "bastion_public_ip" {
  value = "${module.vpc.bastion_public_ip}"
}

output "nat_private_ips" {
  value = "${module.vpc.nat_private_ips}"
}
