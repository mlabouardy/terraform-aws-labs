variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}

variable "ami" {
  description = "CoreOS AMI"
  default = "ami-38714c43"
}

variable "type_instance" {
  description = "Instance type"
  default = "t1.micro"
}

variable "key_path" {
  description = "SSH public key path"
  default = "/home/core/.ssh/id_rsa.pub"
}
