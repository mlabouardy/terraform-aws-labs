provider "aws" {
  region     = "${var.region}"
  secret_key = "${var.secret_key}"
  access_key = "${var.access_key}"
}

resource "aws_security_group" "default" {
  name        = "registry_security_group"
  description = "Allow access to Nexus dashboard & traffic on port 5000"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "registry_security_group"
  }
}

resource "aws_key_pair" "default" {
  key_name   = "registry"
  public_key = "${file("${var.ssh_public_key}")}"
}

resource "aws_eip" "default" {
  instance = "${aws_instance.default.id}"
  vpc      = true
}

data "template_file" "default" {
  template = <<EOF
  yum update
  yum install -y docker
  service docker start
  usermod -aG docker ec2-user
  echo "{"insecure-registries" : ["${var.dns_name}:5000"]}" >> /etc/docker/daemon.json
  service docker restart
  docker swarm init
  docker service create --replicas 1 --name registry --publish 5000:5000 --publish 8081:8081 sonatype/nexus3:3.6.2
EOF

  vars {
    dns_name = "${var.dns_name}"
  }
}

resource "aws_instance" "default" {
  ami             = "${lookup(var.amis, var.region)}"
  instance_type   = "${var.instance_type}"
  key_name        = "${aws_key_pair.default.id}"
  security_groups = ["${aws_security_group.default.name}"]

  user_data = "${file("setup.sh")}"

  user_data = "${data.template_file.default.rendered}"

  tags {
    Name = "registry"
  }
}

resource "aws_route53_record" "default" {
  zone_id = "${var.dns_zone_id}"
  name    = "${var.dns_name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.default.public_ip}"]
}
