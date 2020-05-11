data aws_route53_zone zone {
  count = length(var.domain_names)
  name  = "${element(var.domain_names, count.index)}"
}

resource aws_route53_record cname-root {
  count   = length(var.domain_names)
  zone_id = element(data.aws_route53_zone.zone.*.zone_id, count.index)
  name    = "${element(var.domain_names, count.index)}."
  type    = "A"

  alias {
    zone_id                = element(aws_cloudfront_distribution.cf_distribution.*.hosted_zone_id, count.index)
    name                   = element(aws_cloudfront_distribution.cf_distribution.*.domain_name, count.index)
    evaluate_target_health = false
  }
}

resource aws_route53_record star-alias {
  count   = length(var.domain_names)
  zone_id = element(data.aws_route53_zone.zone.*.zone_id, count.index)
  name    = "*.${element(var.domain_names, count.index)}."
  type    = "A"

  alias {
    zone_id                = element(aws_cloudfront_distribution.cf_distribution.*.hosted_zone_id, count.index)
    name                   = element(aws_cloudfront_distribution.cf_distribution.*.domain_name, count.index)
    evaluate_target_health = false
  }
}

resource aws_route53_record cname-static {
  count   = length(var.domain_names)
  zone_id = element(data.aws_route53_zone.zone.*.zone_id, count.index)
  name    = "static.${element(var.domain_names, count.index)}."
  type    = "CNAME"
  ttl     = 3600
  records = ["s3.amazonaws.com."]
}

resource aws_route53_record api {
  zone_id = element(data.aws_route53_zone.zone.*.zone_id, 0)
  name = aws_api_gateway_domain_name.api.domain_name
  type = "A"

  alias {
    name                   = aws_api_gateway_domain_name.api.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.api.cloudfront_zone_id
    evaluate_target_health = true
  }
}
