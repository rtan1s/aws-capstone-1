module "bastion_vpc" {
  source = "../modules/vpc"

  vpc_cidr               = "10.101.0.0/16"
  azs                    = ["us-east-1a"]
  public_subnet_cidrs    = ["10.101.1.0/24"]
  enable_nat_gateway     = false
  enable_private_subnets = false
  name_prefix            = "bastion"
  environment            = var.environment

  tags = {
    Project     = "bastion"
    Environment = var.environment
  }
}

module "bastion_sg" {
  source        = "../modules/security_group"
  name          = "bastion-sg"
  description   = "Allow SSH access to bastion"
  vpc_id        = module.bastion_vpc.vpc_id
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name = "bastion-sg"
  }
}

module "bastion_instance" {
  source             = "../modules/ec2"
  ami_id             = var.bastion_ami_id
  instance_type      = var.bastion_instance_type
  subnet_id          = module.bastion_vpc.public_subnet_ids[0]
  security_group_ids = [module.bastion_sg.security_group_id]
  associate_public_ip = true
  name_prefix        = "bastion"

  tags = {
    Project     = "bastion"
    Environment = var.environment
  }
}