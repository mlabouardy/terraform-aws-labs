resource "aws_key_pair" "default" {
  key_name = "etcdcluster"
  public_key = "${file("${var.key_path}")}"
}

resource "aws_instance" "node1" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  user_data = "${file("cloud-config.yml")}"

  tags {
    Name = "node1"
  }
}

resource "aws_instance" "node2" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  user_data = "${file("cloud-config.yml")}"

  tags {
    Name = "node2"
  }
}

resource "aws_instance" "node3" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  user_data = "${file("cloud-config.yml")}"

  tags {
    Name = "node3"
  }
}
