provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source         = "../../vpc"
  name           = "test-example"
  aws_key_name   = "test-example"
  enable_bastion = false
}
