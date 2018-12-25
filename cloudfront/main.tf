data "aws_acm_certificate" "cert" {
  count       = "${length(var.domain_names)}"
  domain      = "${element(var.domain_names, count.index)}"
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_api_gateway_rest_api" "rest_api" {
  name = "${var.rest_api_name}"
}

resource "aws_api_gateway_base_path_mapping" "api_mapping" {
  api_id      = "${data.aws_api_gateway_rest_api.rest_api.id}"
  stage_name  = "${var.stage_name}"
  domain_name = "${aws_api_gateway_domain_name.api.domain_name}"
}

resource "aws_api_gateway_domain_name" "api" {
  domain_name     = "api.${element(var.domain_names, 0)}"
  certificate_arn = "${element(data.aws_acm_certificate.cert.*.arn, 0)}"
}

resource "aws_cloudfront_distribution" "cf_distribution" {
  count           = "${length(var.domain_names)}"
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"
  aliases         = ["${element(var.domain_names, count.index)}"]

  origin {
    domain_name = "${aws_api_gateway_domain_name.api.domain_name}"
    origin_id   = "lambda"

    custom_origin_config = {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header = {
      name  = "X-Forwarded-Host"
      value = "${element(var.domain_names, count.index)}"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "lambda"
    compress         = true

    forwarded_values {
      query_string = true

      headers = [
        "CloudFront-Is-Desktop-Viewer",
        "CloudFront-Is-Mobile-Viewer",
        "CloudFront-Is-SmartTV-Viewer",
        "CloudFront-Is-Tablet-Viewer",
        "X-CSRFToken",
        "Referer",
      ]

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 86400
  }

  custom_error_response = {
    error_code            = 403
    error_caching_min_ttl = 0
  }

  custom_error_response = {
    error_code            = 500
    error_caching_min_ttl = 0
  }

  custom_error_response = {
    error_code            = 501
    error_caching_min_ttl = 0
  }

  custom_error_response = {
    error_code            = 502
    error_caching_min_ttl = 0
  }

  custom_error_response = {
    error_code            = 503
    error_caching_min_ttl = 0
  }

  custom_error_response = {
    error_code            = 504
    error_caching_min_ttl = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn = "${element(data.aws_acm_certificate.cert.*.arn, count.index)}"
    ssl_support_method  = "sni-only"
  }
}
