module "vpc" {
  source = "../modules/vpc"

  region        = var.region
  project       = var.project
  vpc_cidr      = "192.170.0.0/16"
  subnet_a_cidr = "192.170.1.0/24"
  subnet_b_cidr = "192.170.2.0/24"
}

# Create the Security Groups
module "sec-groups" {
  source = "../modules/sec-groups"
  sg_name = ""
  project = var.project
  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id
  sg_cidr_blocks = ""
  sg_description = ""
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
  startup_script = "install_space_invaders.sh"

  image_id = {
    us-east-1 = "ami-0be2609ba883822ec",
    us-east-2 = "ami-0a0ad6b70e61be944"
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
  allow_ps = module.sec-groups.allow-ps

  # Passed from Load Balancer Module
  load_balancer_id = module.load-balancer.load_balancer_id
}

module "my_security_group" {
  source         = "./modules/security_group"
  sg_name        = "my-db-sg"
  sg_description = "Security group for my PostgreSQL RDS"
  vpc_id         = "vpc-xxxxxxxx"  # Replace with your VPC ID
  sg_cidr_blocks = ["0.0.0.0/0"]   # Adjust CIDR block as needed
}

module "my_db_subnet_group" {
  source                        = "./modules/db_subnet_group"
  db_subnet_group_name          = "my-db-subnet-group"
  db_subnet_group_description   = "My DB Subnet Group"
  db_subnet_ids                 = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]  # Replace with your subnet IDs
}

module "my_postgres_db" {
  source                    = "./modules/db_instance"
  db_identifier             = "my-postgres-db"
  db_engine_version         = "13.3"  # Adjust version as needed
  db_instance_class         = "db.m5.large"  # Adjust instance class as needed
  db_allocated_storage      = 20  # Storage in GB
  db_storage_type           = "gp2"  # General Purpose SSD
  db_multi_az               = true
  db_subnet_group_name      = module.my_db_subnet_group.db_subnet_group_name
  db_security_group_ids     = [module.my_security_group.id]
  db_username               = "mydbuser"
  db_password               = "mydbpassword"
  db_skip_final_snapshot    = true
  db_publicly_accessible    = false
  db_name                   = "My PostgreSQL DB"
}