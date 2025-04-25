terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = var.tfstate_bucket_name
    key            = var.tfstate_key
    region         = var.tfstate_region
    encrypt        = true
  }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = var.tfstate_bucket_name

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
  bucket = aws_s3_bucket.tfstate.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
