
resource "aws_s3_bucket" "main_bucket" {
  bucket_prefix = var.bucket_prefix
  # versioning {
  #   enabled = true
  # }
  tags = {
    Name = "palash-static-files-bucket"
  }
}
