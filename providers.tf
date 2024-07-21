terraform {
  required_version = ">=  0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "tfstate-terraform-foo-12345"
    region = "us-east-1"
    key    = "foo-common/terraform.tfstate"

    profile = "terraform"
  }
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn     = var.aws_role_arn
    session_name = "terraform-session"
  }
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = var.aws_source_profile
}
