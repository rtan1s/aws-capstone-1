variable "name_prefix" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type        = string
  sensitive   = true
}

variable "security_group_ids" {
  type = list(string)
}

variable "kms_key_id" {
  type = string
}
