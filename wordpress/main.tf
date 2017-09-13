provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_hostname = true

  tags {
    Name = "vpc-blog"
  }
}

resource "aws_subnet" "public-subnet" {
  cidr_block = "${var.public_subnet_cidr_block}"
  vpc_id = "${aws_vpc.default.id}"
  availability_zone = "${var.public_subnet_az}"

  tags {
    Name = "WP Public Subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  cidr_block = "${var.private_subnet_cidr_block}"
  vpc_id = "${aws_vpc.default.id}"
  availability_zone = "${var.private_subnet_az}"

  tags {
    Name = "DB Private Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "WP Internet Gateway"
  }
}

resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "Route table for Public subnet"
  }
}

resource "aws_route_table_association" "default" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.default.id}"
}

resource "aws_security_group" "wpsg" {
  name = "wpsg"
  description = "Allow Incoming HTTP traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Blog Security Group"
  }
}

resource "aws_security_group" "dbsg" {
  name = "dbsg"
  description = "Allow access to MySQL from WP"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${aws_security_group.wpsg.id}"]
  }

  tags {
    Name = "DB Security Group"
  }
}

resource "aws_key_pair" "default" {
  key_name = "blogkey"
  public_key = "${file("${var.key_path}")}"
}

resource "aws_instance" "default" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  user_data = "${file("boostrap.sh")}"
  vpc_security_group_ids = ["${aws_security_group.wpsg.id}"]
  subnet_id = "${aws_subnet.public-subnet.id}"
  associate_public_ip_address = true

  tags {
    Name = "wordpress"
  }
}

resource "aws_db_instance" "default" {
  name = "${var.db_name}"
  engine = "${var.engine}"
  version = "5.6.17"
  storage_type = "gp2"
  allocated_storage = 5
  instance_class = "db.t1.micro"
  username = "${var.db_username}"
  password = "${var.db_password}"
  db_subnet_group_name = "${aws_subnet.private-subnet.id}"
}

resource "aws_elb" "default" {
  name = "elbwp"
  instances = ["${aws_instance.default.id}"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  listener {
    instance_port = 80
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }
}
