variable "tfstate_bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state"
  type        = string
}

variable "tfstate_key" {
  description = "The path inside the S3 bucket where the state file will be stored"
  type        = string
  default     = "terraform.tfstate"
}

variable "tfstate_region" {
  description = "AWS region for the state bucket"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment in which the Terraform infrastructure is being deployed (e.g., dev, prod)"
  type        = string
}
