variable "region" {
  description = "VPC Region"
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  descritpion = "VPC CIDR"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  descritpion = "Public Subnet CIDR"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  descritpion = "Private Subnet CIDR"
  default = "10.0.2.0/24"
}

variable "public_subnet_az" {
  descritpion = "Public Subnet Availability Zone"
  default = "us-east-1a"
}

variable "private_subnet_az" {
  descritpion = "Private Subnet Availability Zone"
  default = "us-east-1b"
}

variable "key_path" {
  description = "Public Key path"
  default = "/home/core/.ssh/id_rsa.pub"
}

variable "ami" {
  description = "Amazon Linux Image"
  default = "ami-"
}

variable "instance_type" {
  description = "Server Instance Type"
  default = "t2.micro"
}

variable "engine" {
  description = "RDS Engine"
  default = "mysql"
}

variable "db_name" {
  description = "Database Name"
  default = "mydb"
}

variable "db_username" {
  description = "Database Username"
}

variable "db_password" {
  description = "Database Password"
}
