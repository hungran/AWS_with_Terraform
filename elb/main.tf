provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}

resource "aws_lb_target_group" "hung-target-group" {
    health_check {
        interval            = 30
        path                = "/"
        protocol            = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
    }
    name     = "hung-target-group"  
    port     = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id      = "${var.vpc_id}"
}
/* resource "aws_lb_target_group_attachment" "hung_lb_target_group_attach_1" {
    target_group_arn    = "${aws_lb_target_group.hung-target-group.arn}"
    target_id           = "${var.instance1_id}"
    port                = 80
}
 resource "aws_lb_target_group_attachment" "hung_lb_target_group_attach_2" {
    target_group_arn    = "${aws_lb_target_group.hung-target-group.arn}"
    target_id           = "${var.instance2_id}"
    port                = 80
 } */
 
resource "aws_lb" "hung_lb" {
    name    = "hung-lb-by-terraform"
    internal = false
    security_groups = ["${var.security_groups}"] // use hung-sg from module vpc
    subnets = [
        "${var.subnet1}", //public subnet 1 from module vpc
        "${var.subnet2}", //public subnet 2 from module vpc
    ]
    tags = {
    Name = "hung-test-lb"
  }

    ip_address_type    = "ipv4"
    load_balancer_type = "application"
}
resource "aws_lb_listener" "my-test-alb-listner" {
  load_balancer_arn = "${aws_lb.hung_lb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.hung-target-group.arn}"
  }
}
