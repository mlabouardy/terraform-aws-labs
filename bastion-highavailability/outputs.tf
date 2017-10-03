output "BASTION-1" {
  value = "${aws_eip.bastion-1a.public_ip}"
}

output "BASTION-2" {
  value = "${aws_eip.bastion-1b.public_ip}"
}

output "PRIVATE-EC2" {
  value = "${aws_instance.private-ec2.private_ip}"
}
