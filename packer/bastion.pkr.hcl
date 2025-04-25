packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

variable "region"   { type = string }
variable "ami_name" { type = string }

source "amazon-ebs" "bastion" {
  region                  = var.region
  instance_type           = "t3.small"
  ssh_username            = "ubuntu"
  ami_name                = var.ami_name
  skip_region_validation  = true

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
      "LATEST_TF=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)",
      "curl -sLo /tmp/terraform.zip https://releases.hashicorp.com/terraform/${LATEST_TF}/terraform_${LATEST_TF}_linux_amd64.zip",
      "sudo unzip -d /usr/local/bin /tmp/terraform.zip",
      "terraform -version"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo pip3 install --upgrade pip",
      "LATEST_ANSIBLE=$(pip3 index versions ansible | grep -Eo 'ansible \\([0-9.]+' | head -1 | cut -d'(' -f2)",
      "sudo pip3 install ansible==${LATEST_ANSIBLE}",
      "ansible --version"
    ]
  }

  post-processor "manifest" {}
}
