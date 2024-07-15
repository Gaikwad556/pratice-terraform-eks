terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.33.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 5.30.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 5.57.0"
    }
  }
  backend "s3" {
    bucket = "gitops-556"
    key = "file/terraform"
    region = "us-east-1"
  }
}
