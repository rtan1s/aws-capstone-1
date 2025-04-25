variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "My Project"
}

variable "vpc_id" {
  type = string
}

variable "sg_name" {
    type = string
}

variable "sg_description" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "sg_cidr_blocks" {
    type = list(string)
}
