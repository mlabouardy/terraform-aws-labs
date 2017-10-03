resource "aws_route53_record" "bastion.slowcoder" {
  zone_id = "${var.zone_id}"
  name = "bastion.slowcoder.com"
  type = "A"
  ttl = "330"
  records = ["${aws_eip.bastion-1a.public_ip}", "${aws_eip.bastion-1b.public_ip}"]
}
