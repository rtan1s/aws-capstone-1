packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.8"
    }
  }
}


source "amazon-ebs" "ubuntu" {
  region                 = "eu-central-1"
  instance_type          = "t3.small"
  ssh_username           = "ubuntu"
  ami_name               = "aws-bastion-u2204-aut-001"
  skip_region_validation = true
  source_ami = "ami-03250b0e01c28d196"
  }

build {
  name    = "ubuntu"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

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
