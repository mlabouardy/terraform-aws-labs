provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

// SSH KeyPair
resource "aws_key_pair" "default" {
  key_name   = "registry"
  public_key = "${file("${var.ssh_public_key}")}"
}

// Jenkins Master
resource "aws_instance" "ci-master" {
  ami = "${lookup()}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  security_groups = ["${aws_security_group.default.name}"]

  user_data = "${file("setup.sh")}"

  tags {
    Name = "ci-master"
  }
}

// Jenkins Slave
resource "aws_instance" "ci-slave" {
  ami = "${lookup()}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"

  tags {
    Name = "ci-slave"
  }
}

// Deployment Environment
resource "aws_instance" "node" {
  count = 3
  ami = "${lookup()}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"

  tags {
    Name = "node-${count.index}"
  }
}
