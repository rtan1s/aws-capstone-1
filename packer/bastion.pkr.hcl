packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.8"
    }
  }
}

variable "region"   { 
    type = string
    description ="the region where the Bastion will be hosted. The bastion will not be HA by design so just a region will be chosen"
    }
variable "ami_name" { 
    type = string
    description ="the AMI that will be used for the Bastion"
    
    }


source "amazon-ebs" "bastion" {
  region                 = var.region
  instance_type          = "t3.small"
  ssh_username           = "ubuntu"
  ami_name               = var.ami_name
  skip_region_validation = true

  source_ami_filter {
    owners      = ["111128952938"]
    most_recent = true
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-22.04-*"
      virtualisation-type = "hvm"
      architecture        = "x86_64"
    }
  }
}

build {
  name    = "bastion"
  sources = ["source.amazon-ebs.bastion"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y curl unzip python3-pip jq"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y git"
    ]
  }
  provisioner "shell" {
    script = "install-terraform.sh"
  }

  provisioner "shell" {
    script = "install-ansible.sh"
  }


  post-processor "manifest" {}
}
