provider "aws" {
    region = var.REGION
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.ca_certificate.certificate_authority.data)
}

data "aws_availability_zones" "available" {}

locals {
    cluster_name = var.CLUSTER_NAME
}