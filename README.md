# Scalable Django Web Infrastructure on AWS using Terraform

This project demonstrates how to host a **Django-based web application** on a **scalable AWS infrastructure**, fully provisioned using **Terraform**.
The focus of this project is to understand how core AWS services work together in a real-world setup and how Infrastructure as Code (IaC) can be used to manage them efficiently.

---

## Architecture Overview

The infrastructure is designed to be secure, scalable, and highly available.

[](https://github.com/rohanan07/Blue-Green-Deploy-TF/blob/main/scalable%20web%20infra%20terraform.png)

**High-level flow:**

Users → Application Load Balancer → Auto Scaling Group → EC2 instances (Dockerized Django app)

EC2 instances run in private subnets and pull the application image from Docker Hub.

---

## AWS Services Used

- **VPC** – Custom VPC with proper subnet isolation  
- **Public Subnets** – For ALB and NAT Gateway  
- **Private Subnets** – For EC2 instances  
- **Internet Gateway** – For inbound/outbound public traffic  
- **NAT Gateway** – For outbound internet access from private subnets  
- **Application Load Balancer (ALB)** – Distributes incoming traffic  
- **Auto Scaling Group (ASG)** – Ensures scalability and availability  
- **EC2** – Hosts the Django application  
- **Docker** – Runs the Django app inside containers  
- **Terraform** – Infrastructure provisioning and management  

---

## Key Features

- Scalable infrastructure across multiple Availability Zones  
- Load-balanced Django application  
- EC2 instances isolated in private subnets  
- Dockerized application deployment  
- Infrastructure fully managed using Terraform  
- Clean Terraform project structure with separated concerns  

---

## Project Structure

├── backend.tf # Remote backend configuration
├── provider.tf # AWS provider configuration
├── variables.tf # Input variables
├── main.tf # Core infrastructure resources
├── vpc.tf # VPC, subnets, IGW, NAT
├── security_groups.tf # Security group rules
├── asg.tf # Launch templates and Auto Scaling Groups
├── alb.tf # Application Load Balancer configuration
├── user_data.sh # EC2 bootstrap script (Docker setup)
└── outputs.tf # Useful outputs

## How the Application is Deployed

- EC2 instances are launched via an Auto Scaling Group
- Docker is installed using a user-data script
- The Django application image is pulled from **Docker Hub**
- The container runs on port 80 and is exposed via ALB

---

## Prerequisites

- AWS account
- Terraform installed
- AWS CLI configured with appropriate permissions

---

## How to Deploy

terraform init
terraform plan
terraform apply
After deployment, access the application using the ALB DNS name output by Terraform.

**Learning Outcomes**
Through this project, I gained hands-on experience with:

-Designing scalable AWS architectures
-Understanding ALB + ASG integration
-Working with private subnets and NAT Gateways
-Using Terraform to manage infrastructure lifecycle
-Running containerized applications on EC2

**Future Improvements**
-Blue-Green deployment strategy
-Container image hosted in Amazon ECR
-CI/CD pipeline for automated deployments
-HTTPS using ACM and Route 53

