module "vpc" {
  source           = "github.com/dpetzold/terraform-aws-zappa/vpc"
  name             = "${var.project_name}"
  aws_key_name     = "${var.project_name}"
  aws_key_location = "${file(var.aws_key_location)}"
}
