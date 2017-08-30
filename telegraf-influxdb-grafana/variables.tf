variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}

variable "ami" {
  description = "Amazon Linux Image"
  default = ""
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "key_path" {
  description = "Public key path"
  default = "/home/core/.ssh/id_rsa.pub"
}
