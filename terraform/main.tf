terraform {
  required_version = ">= 0.14.9"

  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "common" {
  backend = "s3"

  config = {
    bucket = "jf-portfolio-web-tfstate"
    key    = "${var.environment}.terraform.state"
    region = "us-east-1"
  }
}
