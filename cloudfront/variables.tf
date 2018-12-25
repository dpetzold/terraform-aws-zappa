variable "stage_name" {
  description = "The name of the deployment stage"
}

variable "rest_api_name" {
  description = "The name of the api gateway"
}

variable "domain_names" {
  description = "The name of the domain"
  type        = "list"
}
