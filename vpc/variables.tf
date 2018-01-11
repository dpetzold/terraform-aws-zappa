variable "name" {
  description = "VPC name"
}

variable "cidr" {
  description = "cidr"
  default     = "10.10.0.0/16"
}

variable "azs" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "aws_key_name" {
  description = "AWS key name"
}

variable "aws_key_location" {
  description = "AWS key location"
}

variable "repository_name" {
  description = "Name of the ECR repository"
}

// Bastion

variable "bastion_instance_type" {
  description = "Bastion instance type"
  default     = "t2.nano"
}

// NAT

variable "nat_instance_type" {
  description = "NAT instance type"
  default     = "t2.nano"
}

variable "nat_instance_count" {
  default = "1"
}

// RDS

variable "database_username" {
  description = "Database username"
  default     = "postgres"
}

variable "database_port" {
  description = "Database port"
  default     = "5432"
}

variable "database_instance_type" {
  description = "Database instance type"
  default     = "db.t2.micro"
}

// ElastiCache

variable "elasticache_engine_version" {
  description = "Elasticache engine version"
  default     = "3.2.6"
}

variable "elasticache_port" {
  description = "Elasticache port"
  default     = "6379"
}

variable "elasticache_parameter_group_name" {
  description = "Elasticache parameter group name"
  default     = "default.redis3.2"
}

variable "elasticache_instance_type" {
  description = "Elasticache instance type"
  default     = "cache.t2.micro"
}

variable "elasticache_maintenance_window" {
  description = "Elasticache maintenance window"
  default     = "Tue:00:00-Tue:03:00"
}

variable "elasticache_num_cache_nodes" {
  description = "Number of cache nodes"
  default     = "1"
}
