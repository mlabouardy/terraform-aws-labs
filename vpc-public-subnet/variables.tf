variable "aws_region" {
  description = "Region for the VPC"
  default = "eu-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.100.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.100.1.0/24"
}

variable "ami" {
  description = "AMI for EC2"
  default = "ami-a4c7edb2"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/home/core/.ssh/id_rsa.pub"
}
