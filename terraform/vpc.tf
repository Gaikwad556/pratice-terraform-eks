module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "vpro_vpc"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names,0,3)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_dns_hostnames = true
  single_nat_gateway = true

  private_subnet_tags = merge(
    {
      "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
      "kubernetes.io/role/internal-elb"           = "1"
      "Name"                                      = "k8s-private-subnet"
    }
    
  )

  public_subnet_tags = merge(
    {
      "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
      "kubernetes.io/role/elb"                    = "1"
      "Name"                                       = "k8s-public-subnet"
    }
  )
}