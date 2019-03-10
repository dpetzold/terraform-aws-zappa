provider "aws" {
  region = "${var.aws_region}"

  // random: version = "~> 1.1"
  // template: version = "~> 1.0"
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source         = "../../vpc"
  name           = "${var.project_name}"
  aws_key_name   = "${var.project_name}"
  enable_bastion = false
}
