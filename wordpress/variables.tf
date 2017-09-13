variable "region" {
  description = "VPC Region"
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "Public Subnet CIDR"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "Private Subnet CIDR"
  default = "10.0.2.0/24"
}

variable "public_subnet_az" {
  description = "Public Subnet Availability Zone"
  default = "us-east-1a"
}

variable "private_subnet_az" {
  description = "Private Subnet Availability Zone"
  default = "us-east-1b"
}

variable "key_path" {
  description = "Public Key path"
}

variable "ami" {
  description = "Amazon Linux Image"
  default = "ami-4fffc834"
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
