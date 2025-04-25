variable "region" {
  description = "AWS region"
  type        = string
}

variable "db_name" {
  description = "RDS database name"
  type        = string
}

variable "db_user" {
  description = "RDS master username"
  type        = string
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "app_bucket_name" {
  description = "S3 bucket for app files/dumps"
  type        = string
}
