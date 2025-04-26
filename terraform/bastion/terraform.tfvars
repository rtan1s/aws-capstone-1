region         = "us-east-1"
ami_id         = "ami-030baa96fb0a1fac2"              # Replace with AMI from Packer
project = "aer-infra-rt"
instance_type = "t2.medium"
name_prefix = "bastion"
vpc_cidr = "192.169.0.0/16"
subnet_a_cidr = "192.169.1.0/24"
subnet_b_cidr = "192.169.2.0/24"
