module "bastion" {
  source         = "../modules/ec2"
  ami_id         = var.ami_id
  subnet_id      = var.subnet_id
  name_prefix = var.project
  security_group_ids = abs()
  key_name = ""
}