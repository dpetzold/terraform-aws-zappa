variable stage_name {
  description = "The name of the deployment stage"
}

variable api_name {
  description = "The id of the api gateway"
}

variable domain_names {
  description = "The name of the domain"
  type        = list
}

variable wildcard_domains {
  description = "The wildcards domains"
  type        = list
}

variable www_domains {
  description = "The www domains"
  type        = list
}

variable cert_arn { }

variable validation_record {}

locals {
  wildcards_and_domains = concat(var.domain_names, var.wildcard_domains)
}

resource aws_cloudfront_distribution cf_distribution {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"
  aliases         = concat(var.domain_names, var.wwww_names)

  origin {
    domain_name = aws_api_gateway_domain_name.api.domain_name
    origin_id   = "lambda"

    custom_header {
      name  = "X-Forwarded-Host"
      value = "petzold.io"
    }

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
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

  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 500
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 501
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 502
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 503
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 504
    error_caching_min_ttl = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.cert_arn
    ssl_support_method  = "sni-only"
  }
}

resource aws_api_gateway_domain_name api {
  domain_name     = "api.${element(var.domain_names, 0)}"
  certificate_arn = var.cert_arn
}

data aws_api_gateway_rest_api rest_api {
  name = var.api_name
}

resource aws_api_gateway_base_path_mapping api_mapping {
  api_id      = data.aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.stage_name
  domain_name = aws_api_gateway_domain_name.api.domain_name
}
