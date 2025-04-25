module "vpc" {
  source = "../modules/vpc"

  region        = var.region
  project       = var.project
  vpc_cidr      = var.vpc_cidr
  subnet_a_cidr = var.subnet_a_cidr
  subnet_b_cidr = var.subnet_b_cidr
}

# Create the Security Groups
module "sec-groups" {
  source = "../modules/sec-groups"
  project = var.project
  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id

}

# Create the Load Balancer
module "load-balancer" {
  source  = "../modules/alb"
  project = var.project

  # Passed from VPC Module
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id

  # Passed from Sec Groups Module
  allow_http_id = module.sec-groups.allow_http_id
}

# Create the Autoscaling Group
module "autoscaling-group" {
  source = "../modules/autoscaling-group"

  region         = var.region
  project        = var.project
  startup_script = "install-app.sh"

  image_id = {
    us-east-1 = var.ami_id
  }

  instance_type      = "t2.micro"
  instance_count_min = 2
  instance_count_max = 10
  add_public_ip      = true

  # Passed from VPC Module
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id

  # Passed from Sec Groups Module
  allow_http_id = module.sec-groups.allow_http_id
  allow_ssh_id  = module.sec-groups.allow_ssh_id


  # Passed from Load Balancer Module
  load_balancer_id = module.load-balancer.load_balancer_id
}