terraform {
  backend "s3" {
    bucket         = "palash-terraform-state-bucket" 
    key            = "terraform/state.tfstate"
    region         = "us-east-1" 
    encrypt        = true
    dynamodb_table = "Palash-terraform-locks" 
  }
}
