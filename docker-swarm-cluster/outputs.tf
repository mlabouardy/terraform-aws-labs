output "MASTER" {
  value = "${aws_instance.master.public_ip}"
}

output "WORKER1" {
  value = "${aws_instance.worker1.public_ip}"
}

output "WORKER2" {
  value = "${aws_instance.worker2.public_ip}"
}
