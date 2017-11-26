variable "region" {
  description = "AWS Region"
}

variable "access_key" {
  description = "AWS Access Key ID"
}

variable "secret_key" {
  description = "AWS Secret Key"
}

variable "key_name" {
  description = "SSH KeyPair"
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
}

variable "hostname" {
  description = "EC2 hostname"
  default = "tick_stack"
}

variable "ami" {
  description = "Ubuntu Server 16.04 LTS"
  default = "ami-da05a4a0"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default = "t2.micro"
}

variable "sg_name" {
  description = "Security Group name"
  default = "tick_sg"
}

variable "sg_description" {
  description = "SG description"
  default = "Allow InfluxDB, Chronograf & SSH access"
}
