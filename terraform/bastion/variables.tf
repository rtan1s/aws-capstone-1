variable "project" {
  description = "Public subnet ID for bastion"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for bastion host"
  type        = string
}

variable "key_pair_name" {
  description = "Key pair name for bastion SSH access"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to launch bastion in"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID for bastion"
  type        = string
}
