variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "versioning" {
  type        = bool
  default     = true
  description = "Enable versioning for the bucket"
}

variable "attach_policy" {
  type        = bool
  default     = false
  description = "Whether to attach a bucket policy"
}

variable "bucket_policy_json" {
  type        = string
  default     = ""
  description = "JSON-formatted bucket policy"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the bucket"
}
