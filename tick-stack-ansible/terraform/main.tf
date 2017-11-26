provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


module "tick_sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"

  name = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id = "${var.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 8083
      to_port     = 8083
      protocol    = "tcp"
      description = "InfluxDB admin dashboard"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8086
      to_port     = 8086
      protocol    = "tcp"
      description = "InfluxDB API"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8888
      to_port     = 8888
      protocol    = "tcp"
      description = "Chronograf Dashboard"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH access"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "tick_stack" {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"

  name = "${var.hostname}"
  ami = "${var.ami}"

  key_name = "${var.key_name}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${module.tick_sg.this_security_group_id}"]

  tags {
    Name = "${var.hostname}"
  }
}
