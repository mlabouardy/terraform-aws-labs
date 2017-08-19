# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "vpctestkeypair"
  public_key = "${file("${var.key_path}")}"
}

# Define 2 EC2 instances
resource "aws_instance" "wb1" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.web-public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   associate_public_ip_address = true
   source_dest_check = false

  tags {
    Name = "wb1"
  }
}

resource "aws_instance" "wb2" {
  ami  = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.default.id}"
  subnet_id = "${aws_subnet.web-public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
  associate_public_ip_address = true
  source_dest_check = false

  tags {
    Name = "wb2"
  }
}
