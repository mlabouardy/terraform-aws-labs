resource "aws_instance" "bastion-1a" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${aws_subnet.us-east-1a-public.id}"
  associate_public_ip_address = true

  tags {
    Name = "bastion-1a"
  }
}

resource "aws_eip" "bastion-1a-eip" {
  instance = "${aws_instance.bastion-1a.id}"
  vpc = true
}

resource "aws_instance" "bastion-1b" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${aws_subnet.us-east-1b-public.id}"
  associate_public_ip_address = true

  tags {
    Name = "bastion-1b"
  }
}

resource "aws_eip" "bastion-1b-eip" {
  instance = "${aws_instance.bastion-1b.id}"
  vpc = true
}

resource "aws_instance" "private-ec2" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${aws_subnet.us-east-1a-private.id}"

  tags {
    Name = "private-ec2"
  }
}
