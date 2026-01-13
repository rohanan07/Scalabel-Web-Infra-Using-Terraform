# Scalable Django Web Infrastructure on AWS using Terraform

This repository contains the Terraform code for a project where I hosted a **Django-based web application** on a **scalable AWS infrastructure**.
The objective of this project was to gain hands-on experience with AWS networking, compute, and load balancing concepts, and to manage the entire setup using **Infrastructure as Code (Terraform)**.

---

## Architecture Summary

The infrastructure consists of a single scalable environment designed for high availability.

**Traffic flow:**

Users → Application Load Balancer → Auto Scaling Group → EC2 instances (Dockerized Django app)

EC2 instances run in private subnets and pull the application image from Docker Hub.

![Scalable Django Web Infrastructure](https://github.com/rohanan07/Blue-Green-Deploy-TF/blob/main/scalable%20web%20infra%20terraform.png)

---

## What Was Implemented

- A custom **VPC** with CIDR-based subnetting
- **Public subnets** across multiple Availability Zones for ALB and NAT Gateway
- **Private subnets** across multiple Availability Zones for EC2 instances
- **Internet Gateway** for inbound internet access
- **NAT Gateway** to allow private instances outbound access
- **Application Load Balancer** to distribute incoming traffic
- **Auto Scaling Group** with EC2 instances spread across AZs
- **Launch Template** for EC2 configuration and bootstrapping
- **Docker** installed via user-data and used to run the Django application
- Django application image pulled from **Docker Hub**
- All infrastructure provisioned and managed using **Terraform**

---

## Project Structure

The Terraform configuration is organized into multiple files based on responsibility:

```
├── backend.tf # Remote backend configuration
├── provider.tf # AWS provider configuration
├── variables.tf # Input variables
├── main.tf # Core infrastructure setup
├── vpc.tf # VPC, subnets, IGW, NAT Gateway
├── security_groups.tf # Security group rules
├── alb.tf # Application Load Balancer
├── asg.tf # Launch Template and Auto Scaling Group
├── user_data.sh # EC2 bootstrap script
└── outputs.tf # Output values (ALB DNS, etc.)
```
## Application Deployment Details

- EC2 instances are launched through an Auto Scaling Group
- Docker is installed at instance boot time using a user-data script
- The Django application runs inside a Docker container
- The container listens on port 80 and is accessed through the ALB

---

## Key Learnings

- Designing scalable architectures using ALB and ASG
- Working with public and private subnets in AWS
- Understanding the role of NAT Gateway for private instances
- Managing infrastructure lifecycle using Terraform
- Running containerized applications on EC2

---

## Current Scope

This project currently represents **a single scalable environment**.
I am experimenting with extending this setup further (such as deployment strategies), but this repository reflects the stable and working version of the infrastructure.

---
