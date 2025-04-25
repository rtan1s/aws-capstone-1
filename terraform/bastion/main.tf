module "bastion" {
  source         = "../modules/bastion"
  region         = var.region
  ami_id         = var.ami_id
  key_pair_name  = var.key_pair_name
  vpc_id         = var.vpc_id
  subnet_id      = var.subnet_id
}