// Lấy ID của instance

output "instance1_id" {
  value = "${element(aws_instance.hung_terraform_ubuntu.*.id, 1)}"
}

output "instance2_id" {
  value = "${element(aws_instance.hung_terraform_ubuntu.*.id, 2)}"
}

output "key_name" {
  value = "${aws_key_pair.public_key.key_name}"
}

output "instance_id" {
  value = "${aws_instance.hung_terraform_ubuntu.*.id}"
}
