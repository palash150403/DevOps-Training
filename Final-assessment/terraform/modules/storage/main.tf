# modules/storage/main.tf
# resource "aws_s3_bucket" "static_assets" {
#   bucket = var.bucket_name
#   # acl    = "public-read"

#   tags = {
#     Name = "palash-s3-ecom-bucket"
#   }
# }

# resource "aws_s3_bucket_object" "sample_files" {
#   count   = length(var.file_paths)
#   bucket  = aws_s3_bucket.static_assets.bucket
#   key     = element(var.file_paths, count.index)
#   source  = element(var.file_sources, count.index)
#   acl     = "public-read"
# }

# modules/storage/main.tf
resource "aws_s3_bucket" "static_assets" {
  bucket = var.bucket_name
  # instance_profile   = var.instance_profile
  # acl    = "public-read"  

  tags = {
    Name = "spalash-ecom-assets-bucket"
  }
}

resource "aws_s3_object" "sample_files" {
  count   = length(var.file_paths)
  bucket  = aws_s3_bucket.static_assets.bucket
  key     = element(var.file_paths, count.index)
  source  = element(var.file_sources, count.index)
  acl     = "public-read"  # Ensure this matches with your bucket's ACL settings
}

## main
# # modules/storage/main.tf
# resource "aws_s3_bucket" "static_assets" {
#   bucket = var.bucket_name
#   # acl    = "private"  

#   tags = {
#     Name = "palash-ecom-assets-bucket"
#   }
# }
## main


# resource "aws_s3_object" "sample_files" {
#   count   = length(var.file_paths)
#   bucket  = aws_s3_bucket.static_assets.bucket
#   key     = element(var.file_paths, count.index)
#   source  = element(var.file_sources, count.index)
#   acl     = "private"  
# }


