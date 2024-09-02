provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "palash-terraform-state-bucket"

  tags = {
    Name = "palash-terraform-state-bucket"
  }
}


resource "aws_dynamodb_table" "terraform_locks" {
  name         = "Palash-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  Palash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}

