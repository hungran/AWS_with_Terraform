output "public_subnets" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "security_group" {
  value = "${aws_security_group.hung_sg.id}"
}

output "vpc_id" {
  value = "${aws_vpc.hung_vpc_2020.id}"
}

output "public_subnet1" {
  value = "${element(aws_subnet.public_subnet.*.id, 1)}"
}

output "public_subnet2" {
  value = "${element(aws_subnet.public_subnet.*.id, 2)}"
}

output "private_subnet1" {
  value = "${element(aws_subnet.private_subnet.*.id, 1)}"
}

output "private_subnet2" {
  value = "${element(aws_subnet.private_subnet.*.id, 2)}"
}