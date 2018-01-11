resource "aws_route53_zone" "internal" {
  name   = "internal"
  vpc_id = "${module.vpc.vpc_id}"
}

resource "aws_route53_record" "internal-ns" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "internal"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.internal.name_servers.0}",
    "${aws_route53_zone.internal.name_servers.1}",
    "${aws_route53_zone.internal.name_servers.2}",
    "${aws_route53_zone.internal.name_servers.3}",
  ]
}

resource "aws_route53_record" "postgres" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "postgres.internal"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.db.this_db_instance_address}"]
}

resource "aws_route53_record" "redis" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "redis.internal"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elasticache_cluster.redis.cache_nodes.0.address}"]
}
