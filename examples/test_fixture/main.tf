provider "aws" {
  region = "${var.region}"

  // random: version = "~> 1.1"
  // template: version = "~> 1.0"
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source         = "../../vpc"
  name           = "test-example"
  aws_key_name   = "test-example"
  enable_bastion = false
}
