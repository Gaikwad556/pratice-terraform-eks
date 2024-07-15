module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true

    vpc_id                   = module.vpc.vpro_vpc
  subnet_ids               = [module.vpc.public_subnets]


    eks_managed_node_group_defaults = {
        ami_type       = "AL2023_x86_64"
  }

    eks_managed_node_groups = {
    one = {
      instance_types = ["t2.micro"]

      min_size     = 2
      max_size     = 4
      desired_size = 1
    }

    two = {
      instance_types = ["t2.micro"]

      min_size     = 2
      max_size     = 4
      desired_size = 1
    }
  }
}