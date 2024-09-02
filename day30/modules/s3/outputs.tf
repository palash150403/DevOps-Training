output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.app_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.app_bucket.arn
}
