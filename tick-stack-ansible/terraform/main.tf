provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secrey_key}"
}


module "tick-sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"
  
  name = "${var.sg_name}"
  description = "${var.sg_description}"

  
}

module "tick-stack" {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  
  name = "${var.hostname}"
  ami = "${var.ami}"
  
  key_name = "${var.key_name}"
  instance_type = "${var.instance_type}"
  vpc_security_groups_ids = [""]

  tags {
    Name = "${var.hostname}"
  }
}
