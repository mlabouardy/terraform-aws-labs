variable "region" {}
variable "secret_key" {}
variable "access_key" {}
variable "ssh_public_key" {}
variable "dns_zone_id" {}

variable "instance_type" {
  default = "t2.medium"
}

variable "amis" {
  type        = "map"
  description = "Amazon Linux Image"

  default = {
    "us-east-1"  = "ami-55ef662f"
    "us-east-2"  = "ami-15e9c770"
    "eu-west-2"  = "ami-e7d6c983"
    "eu-west-1"  = "ami-1a962263"
    "ap-south-1" = "ami-d5c18eba"
  }
}

variable "dns_name" {
  default = "registry.slowcoder.com"
}
