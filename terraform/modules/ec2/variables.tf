variable "ami_id" {
  description = "AMI ID to use for the instance (e.g. from Packer)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}

variable "iam_instance_profile" {
  description = "IAM instance profile name (optional)"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "name_prefix" {
  type = string
}
