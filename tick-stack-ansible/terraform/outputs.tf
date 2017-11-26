output "instance_public_dns" {
  value = "${module.tick_stack.public_dns[0]}"
}
