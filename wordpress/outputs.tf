output "ELB_DNS" {
  value = "${aws_elb.default.dns_name}"
}

output "Blog_DNS" {
  value = "${aws_instance.default.public_dns}"
}

output "MYSQL_DNS" {
  value = "${aws_db_instance.default.dns_name}"
}
