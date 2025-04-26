# aws-capstone-1
Capstone project  assigned as final task for AWS Engagement Ready Program - Cohort 1: Week 1 / Infrastructure


---

```markdown
# AWS Infrastructure for Multi-AZ Containerized Application Deployment

This project builds a scalable, resilient AWS infrastructure for deploying a containerized application using Terraform, Packer, and Ansible. The infrastructure spans multiple Availability Zones in the `us-east-1` region and includes a non-HA bastion host for management and automation purposes.

## Technologies Used

- **Terraform**: Infrastructure as Code (IaC)
- **Packer**: Custom AMI creation for the bastion host
- **Ansible**: Post-deployment configuration (e.g., PostgreSQL setup)
- **GitHub Actions**: CI/CD automation

## Project Structure
![image](https://github.com/user-attachments/assets/aa36b731-3325-4f00-9f78-06a648ca893f)


## Prerequisites

- tfstate regitered locally
- Terraform >= 1.11.4
- Packer >= 1.9.0
- GitHub repository
- IAM permissions to manage:
  - EC2, EKS, ALB, VPC

## Step-by-Step Setup
### 0. Clone the repository locally
git clone https://github.com/rtan1s/aws-capstone-1.git

### 1. Build the Bastion AMI with Packer

Navigate to the Packer directory inside `aws-capstone-1/`:

```bash
cd ../packer/bastion
packer init bastion.pkr.hcl
packer build bastion.pkr.hcl
```

Copy the resulting AMI ID and update `terraform.tfvars` under `bastion/` with it.

### 2. Deploy Bastion Host

Navigate to the `bastion/` directory and apply:

```bash

terraform init
terraform apply
```

This deploys a single EC2 bastion host in its own VPC.

Clone the repository into the bastion
```bash
git clone https://github.com/rtan1s/aws-capstone-1.git
```

### 3. Test the automation environment
clone 

Navigate to the `ec2-test/` directory and apply:

```bash

terraform init
terraform apply
```

then destroy the environment with
```bash

terraform destroy

```


### 4. Build the appserver AMI with Packer

Navigate to the Packer directory inside `bastion/`:

```bash
cd ../packer/appserver
packer init appserver.pkr.hcl
packer build appserver.pkr.hcl
```

Copy the resulting AMI ID and update `terraform.tfvars` under `appserver/` with it.

### 5. Deploy Application Infrastructure

Move to the application folder:

```bash
cd ../../app
terraform init
terraform apply
```

This deploys:

- VPC with private subnets in two AZs
- EC2 instances and application binaries
- Application Load Balancer

from the output of terraform , identify the LB url (i.e. alb-amazon.aws.com)
Browse the URL found:
  i.e. http://alb-amazon.aws.com
to check if the application is working

### 6. Final GitHub upload

#### Push to Main

```bash
git add .
git commit -m "Initial infrastructure deployment"
git push origin main
```

## Clean-Up

To destroy the application infrastructure (keeping the bastion alive):

```bash
cd app
terraform destroy
```

