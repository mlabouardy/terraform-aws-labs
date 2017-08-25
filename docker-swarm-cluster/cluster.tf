resource "aws_key_pair" "default"{
  name = "clusterkp"
  public_key = "${file("${var.key_path}")}"
}

resource "aws_instance" "master" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  user_data = "${file("${var.bootstrap_path}")}"

  tags {
    Name  = "master"
  }
}
