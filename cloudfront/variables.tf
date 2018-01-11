variable "stage_name" {
  description = "The name of the deployment stage"
}

variable "api_id" {
  description = "The id of the api gateway"
}

variable "domain_names" {
  description = "The name of the domain"
  type        = "list"
}
