resource "aws_s3_bucket" "dr_backup" {
  bucket        = "dr-backup-bucket-1"
  force_destroy = true

  tags = {
    Name = "DR Backup Bucket"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "dr_backup_lifecycle" {
  bucket = aws_s3_bucket.dr_backup.id

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backup.id

  versioning_configuration {
    status = "Enabled"
  }
}

