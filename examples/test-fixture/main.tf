provider "aws" {
  region = "${var.aws_region}"
}

module "vpc" {
  source       = "../../vpc"
  name         = "${var.project_name}"
  aws_key_name = "${var.project_name}"
}
