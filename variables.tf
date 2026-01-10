variable "vpc_cidr_block" {
    type = string
    default = "10.1.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
  default = [ "10.1.0.0/24", "10.1.1.0/24" ]
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
  default = [ "10.1.10.0/24", "10.1.11.0/24" ]
}

variable "availability_zones" {
  type = list(string)
  default = [ "ap-south-1a", "ap-south-1b" ]
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-02b8269d5e85954ef" # Ubuntu
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.micro"
}