variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "name_prefix" {
  type = string
}
