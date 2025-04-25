module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.private_subnet_ids
  vpc_id          = var.vpc_id

  node_groups = {
    main = {
      desired_capacity = 3
      max_capacity     = 4
      min_capacity     = 2
      instance_types   = ["t3.medium"]
      subnets          = var.private_subnet_ids
    }
  }
}
