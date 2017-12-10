output "Registry IP" {
  value = "${aws_eip.default.public_ip}"
}
