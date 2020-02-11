output "elb_dns_name" {
  value = "${module.elb.elb_dns_name}"
}
output "elb_zone_id" {
  value = "${module.elb.elb_zone_id}"
}
/*
output "instance1_id" {
  value = "${element(module.ec2.instance1_id)}"
}

output "instance2_id" {
  value = "${element(module.ec2.instance2_id)}"
}
*/