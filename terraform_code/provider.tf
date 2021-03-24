# Provider configuration
# Note: Change the region name as per requirement

provider "aws" {
  region = "us-east-1"
}

# This block is responsible for storing terraform state file in S3
terraform {
  backend "s3" {
    bucket = "terraform-iac-sbx-lambda-deployment"
    key    = "terraform_state/terraform.tfstate"
    region = "us-east-1"
  }
}
