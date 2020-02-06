output "elb_dns_name" {
  value = "${aws_lb.hung_lb.dns_name}"
}

output "target_group_arn" {
  value = "${aws_lb_target_group.hung-target-group.arn}"
}