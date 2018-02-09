variable "project_name" {
  description = "Project name"
}

variable "aws_key_location" {
  description = "Location of private key"
}

variable "nat_instance_count" {
  description = "Number of NAT instances"
}

variable "database_username" {
  description = "Database username"
}

variable "database_read_replicas" {
  description = "Database read replicas"
}

variable "database_backup_retention_period" {
  description = "Database read replicas"
}

variable "database_multi_az" {
  description = "Database multi az"
}

variable "redis_instance_type" {
  description = "Instance type for redis"
}

variable "redis_number_cache_clusters" {
  description = "Number of redis cache clusters"
}

variable "redis_automatic_failover_enabled" {
  description = "Enable automatic failover for redis"
}

variable "redis_at_rest_encryption_enabled" {
  description = "Enable encryption at rest"
}

variable "redis_transit_encryption_enabled" {
  description = "Enable transit encryption "
}
