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

```
project-root/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── bastion/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   └── packer/
│       └── bastion.pkr.hcl
├── app/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   ├── modules/
│   │   ├── vpc/
│   │   ├── eks/
│   │   ├── alb/
│   │   ├── rds/
│   │   ├── ec2/
│   │   └── s3/
├── state-backend/
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
```

## Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform >= 1.6.0
- Packer >= 1.9.0
- Ansible >= 2.15
- GitHub repository with AWS credentials stored as secrets
- IAM permissions to manage:
  - EC2, S3, RDS, EKS, ALB, VPC, KMS

## Step-by-Step Setup

### 1. Create S3 Backend for Terraform State

Navigate to the `state-backend/` directory:

```bash
cd state-backend
terraform init
terraform apply
```

This creates an S3 bucket with server-side encryption for storing Terraform state remotely.

### 2. Build the Bastion AMI with Packer

Navigate to the Packer directory inside `bastion/`:

```bash
cd ../bastion/packer
packer init bastion.pkr.hcl
packer build bastion.pkr.hcl
```

Copy the resulting AMI ID and update `terraform.tfvars` under `bastion/` with it.

### 3. Deploy Bastion Host

Navigate to the `bastion/` directory and apply:

```bash
cd ..
terraform init
terraform apply
```

This deploys a single EC2 bastion host in its own VPC.

### 4. Deploy Application Infrastructure

Move to the application folder:

```bash
cd ../../app
terraform init
terraform apply
```

This deploys:

- VPC with public/private subnets in two AZs
- EKS cluster across multiple AZs
- RDS PostgreSQL (Multi-AZ)
- Application Load Balancer
- KMS keys
- S3 buckets
- EC2 instances for automation (if required)

### 5. Configure PostgreSQL with Ansible

Once the RDS instance is available and reachable from the bastion, use Ansible to run initialization scripts:

```bash
ansible-playbook -i inventory.ini playbooks/postgres-setup.yml
```

Make sure to run this command from a system with access to the bastion or directly on the bastion if needed.

### 6. Enable GitHub Actions for CI/CD

This project includes a GitHub Actions workflow (`.github/workflows/deploy.yml`) that runs `terraform plan` and `terraform apply` automatically on push to the `main` branch.

#### GitHub Secrets Required

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `TF_VAR_tfstate_bucket_name`
- `TF_VAR_tfstate_region`
- Any other variables used in `terraform.tfvars`

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

To destroy the bastion host as well:

```bash
cd ../bastion
terraform destroy
```

