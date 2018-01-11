output "lambda_subnet_ids" {
  value = "${module.vpc.private_subnets}"
}

output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "postgres_cname" {
  value = "${aws_route53_record.postgres.name}"
}

output "postgres_password" {
  value = "${module.db.this_db_instance_password}"
}

output "redis_cname" {
  value = "${aws_route53_record.redis.name}"
}

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "nat_private_ips" {
  value = ["${module.nat.private_ips}"]
}

output "repository_arn" {
  value = "${aws_ecr_repository.repository.arn}"
}

output "repository_url" {
  value = "${aws_ecr_repository.repository.repository_url}"
}
