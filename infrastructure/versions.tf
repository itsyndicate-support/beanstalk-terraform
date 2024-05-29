
terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "states-bucket-512"
    encrypt = true
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

