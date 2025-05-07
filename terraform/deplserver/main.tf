module "ec2" {
  source             = "../modules/ec2"
  instance_type      = var.instance_type
  ami_id             = var.ami_id 
  name_prefix        = var.name_prefix
  vpc_id =  "vpc-058ef2bc9f1601b60"
  subnet_id = "subnet-0f456b30a6850e2d3"
}