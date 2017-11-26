variable "region" {
  description = "AWS Region"
}

variables "access_key" {
  description = "AWS Access Key ID"
}

variables "secret_key" {
  description = "AWS Secret Key"
}

variable "key_name" {
  description = "SSH KeyPair"
}

variable "hostname" {
  description = "EC2 hostname"
  default = "tick_stack"
}

variable "ami" {
  description = "Amazon Linux Image"
  default = "ami-55ef662f"
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
