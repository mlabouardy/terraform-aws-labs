provider "aws" {
  region = "${var.region}"
}

resource "aws_security_group" "default"{
  name = "metricssg"

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "default" {
  key_name = "metricskp"
  public_key = "${file("${var.key_path}/id_rsa.pub")}"
}

resource "aws_instance" "default" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  security_groups = ["${aws_security_group.default.name}"]
  user_data = "${file("${var.bootstrap_script}")}"

  tags {
    Name = "athena"
  }

  provisioner "file" {
    source = "telegraf-influxdb-grafana/"
    destination = "/home/ec2-user/"

    connection {
       type = "ssh"
       user = "ec2-user"
       private_key = "${file("${var.key_path}/id_rsa")}"
    }
  }
}
