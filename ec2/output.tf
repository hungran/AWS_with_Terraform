output "instance_id" {
  value = "${element(aws_instance.hung_terraform_ubuntu.*.id, 1)}"
}

output "instance2_id" {
  value = "${element(aws_instance.hung_terraform_ubuntu.*.id, 2)}"
}
