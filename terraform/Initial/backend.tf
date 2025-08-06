provider "aws" {
  region = "us-east-1" # Replace with your preferred region
}

# S3 Bucket for Terraform Backend
resource "aws_s3_bucket" "dr_backend" {
  bucket        = "dr-terraform-backend-bucket"
  force_destroy = true

  tags = {
    Name = "DR Terraform Backend Bucket"
  }
}

# Enable Versioning (IMPORTANT for state recovery)
resource "aws_s3_bucket_versioning" "dr_backend_versioning" {
  bucket = aws_s3_bucket.dr_backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

# (Optional) Lifecycle Rule to clean up incomplete uploads, etc.
resource "aws_s3_bucket_lifecycle_configuration" "dr_backend_lifecycle" {
  bucket = aws_s3_bucket.dr_backend.id

  rule {
    id     = "cleanup-incomplete-multipart-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# (Optional) Encryption - Server-side AES256
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.dr_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# (Optional) Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.dr_backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
