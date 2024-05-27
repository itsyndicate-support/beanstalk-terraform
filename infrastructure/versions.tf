
terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "state-bucket-512"
    encrypt = true
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}}
