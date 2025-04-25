variable "region"   { 
    type = string
    description ="the region where the Bastion will be hosted. The bastion will not be HA by design so just a region will be chosen"
    default = "us-east-1"
    }
variable "ami_name" { 
    type = string
    description ="the AMI that will be used for the Bastion"
    default = "aws-bastion-u2204-aut-001"
    }