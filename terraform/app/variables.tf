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
  default = "us-east-1"
}