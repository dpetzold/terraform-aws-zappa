variable "stage_name" {
  description = "The name of the deployment stage"
}

variable "origin_domain_name" {
  description = "The address of the origin domain"
}

variable "domain_names" {
  description = "The name of the domain"
  type        = "list"
}
