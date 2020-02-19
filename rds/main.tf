provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}
resource "aws_db_instance" "hung-rds-mysql" {
    allocated_storage = 20
    max_allocated_storage = 0
    monitoring_interval = 0
    multi_az = true
    storage_type = "gp2"
    instance_class = "${var.db_instance}"
    engine          = "mysql"
    username        = "root"
    password        = "Password123"
    engine_version  = "5.7"
    name            = "hungdb"
    db_subnet_group_name = "${aws_db_subnet_group.private_subnets.name}"
    vpc_security_group_ids = ["${aws_security_group.hung-rds-sg.id}"]
}
resource "aws_security_group" "hung-rds-sg" {
  name = "hung-rds-sg"
  vpc_id = "${var.vpc_id}"
}
resource "aws_db_subnet_group" "private_subnets" {
  name = "private_subnets"
  subnet_ids = ["${var.private_subnet1}","${var.private_subnet2}"]
}
resource "aws_security_group_rule" "allow_3306" {
  from_port = 3306
  protocol = "tcp"
  security_group_id = "${aws_security_group.hung-rds-sg.id}"
  to_port = 3306
  type = "ingress"
  cidr_blocks = ["192.168.0.0/16"]

}
resource "aws_security_group_rule" "allow_22" {
  from_port = 22
  protocol = "tcp"
  security_group_id = "${aws_security_group.hung-rds-sg.id}"
  to_port = 22
  type = "ingress"
  cidr_blocks = ["192.168.0.0/16"]

}
resource "aws_security_group_rule" "out_bound" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.hung-rds-sg.id}"
  to_port = 0
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]

}
