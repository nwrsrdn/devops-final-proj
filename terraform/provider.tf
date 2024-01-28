terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }

  backend "s3" {
    region         = "ap-southeast-1"
    bucket         = "erwin-bucket"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform_state_file_lock"
  }
}

provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      ProjectCode = "Final-Project"
      Engineer    = "Erwin"
      App         = "Vote-app"
    }
  }
}
