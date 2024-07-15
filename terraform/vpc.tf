module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpro_vpc"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available,0,3)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  private_subnet_tags = merge(
    {
      "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
      "kubernetes.io/role/internal-elb"           = "1"
      "Name"                                      = "k8s-private-subnet"
    },
    var.additional_private_subnet_tags
  )

  public_subnet_tags = merge(
    {
      "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
      "kubernetes.io/role/elb"                    = "1"
      "Name"                                       = "k8s-public-subnet"
    },
    var.additional_public_subnet_tags
  )
}