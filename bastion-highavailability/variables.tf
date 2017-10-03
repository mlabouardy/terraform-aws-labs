variable "key_name" {}
variable "zone_id" {}

variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  default = "10.0.0.0/16"
}

variable "us_east_1a_public_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.1.0/24"
}

variable "us_east_1b_public_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.2.0/24"
}

variable "us_east_1a_private_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.3.0/24"
}

variable "availability_zones" {
  type = "map"
  description = "Availability Zones by CIDR"
  default = {
    "10.0.1.0/24" = "us-east-1a"
    "10.0.2.0/24" = "us-east-1b"
    "10.0.3.0/24" = "us-east-1a"
  }
}

variable "amis" {
  type = "map"
  description = "AMIs by region"
  default = {
    us-east-1 = "ami-4fffc834"
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}
