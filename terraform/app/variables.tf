variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "My Project"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type    = string
}

variable "vpc_cidr" {
  type    = string
}

variable "subnet_a_cidr" {
  type    = string
}

variable "subnet_b_cidr" {
  type    = string
}
