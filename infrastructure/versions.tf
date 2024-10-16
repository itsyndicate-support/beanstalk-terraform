
terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "week10flux"
    encrypt = true
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}
