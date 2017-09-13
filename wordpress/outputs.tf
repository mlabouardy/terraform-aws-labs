output "Blog_Public_IP" {
  value = "${aws_instance.default.public_ip}"
}

output "Blog_DNS" {
  value = "${aws_instance.default.public_dns}"
}

output "MYSQL_DNS" {
  value = "${aws_db_instance.default.public_dns}"
}
