module "vpc" {
  source = "../modules/network"
  region = var.region
  azs = abs()
  vpc_cidr = abs()
  name_prefix = ""
}

module "eks" {
  source     = "../modules/eks"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}

module "rds" {
  source          = "../modules/rds"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  db_name         = var.db_name
  db_username = var.db_user
  db_password     = var.db_password
  kms_key_id      = module.kms.key_id
  security_group_ids = ""
  allocated_storage = ""
  instance_class = ""
  
  name_prefix = ""
  private_subnet_ids = 
}

module "alb" {
  source     = "../modules/alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
}

module "s3" {
  source = "../modules/s3"
  bucket_name = var.app_bucket_name
}

module "kms" {
  source = "../modules/kms"
  alias  = "alias/app-secrets"
}

module "security_groups" {
  source = "../modules/security_groups"
  vpc_id = module.vpc.vpc_id
}
