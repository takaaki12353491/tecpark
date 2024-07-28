# ---------------------------------------------
# Terraform configuration
# ---------------------------------------------
terraform {
  required_version = ">=0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# ---------------------------------------------
# Provider
# ---------------------------------------------
provider "aws" {
  profile = "tecpark-stg"
  region  = "ap-northeast-1"
}

module "network" {
  source = "../../../module/network"
  environment = "${var.environment}"
  project = "${var.project}"
}