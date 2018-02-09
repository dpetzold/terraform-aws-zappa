module "lambda" {
  source             = "../cloudfront"
  domain_names       = "${var.domain_names}"
  stage_name         = "${var.stage_name}"
  origin_domain_name = "${var.origin_domain_name}"
}
