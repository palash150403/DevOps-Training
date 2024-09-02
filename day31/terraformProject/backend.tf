terraform {
  backend "s3" {
    bucket         = "tfstate-store-bucket-palash1" 
    key            = "terraform/state.tfstate"
    region         = "us-west-1" 
    encrypt        = true
    dynamodb_table = "terraform-locks-palash1" 
  }
}
