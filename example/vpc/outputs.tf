output "lambda_subnet_ids" {
  value = "${module.vpc.lambda_subnet_ids}"
}

output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "postgres_cname" {
  value = "${module.vpc.postgres_cname}"
}

output "postgres_password" {
  value = "${module.vpc.postgres_password}"
}

output "redis_cname" {
  value = "${module.vpc.redis_cname}"
}

output "bastion_public_ip" {
  value = "${module.vpc.bastion_public_ip}"
}

output "nat_private_ips" {
  value = "${module.vpc.nat_private_ips}"
}
