output "BASTION-1" {
  value = "${aws_eip.bastion-1a-eip.public_ip}"
}

output "BASTION-2" {
  value = "${aws_eip.bastion-1b-eip.public_ip}"
}

output "PRIVATE-EC2" {
  value = "${aws_instance.private-ec2.private_ip}"
}
