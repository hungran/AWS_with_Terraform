provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}
data "template_file" "bootstrap" {
  template = "${file("./bootstrap.tpl")}"
}
resource "aws_launch_configuration" "hung_launch_config" {
  name_prefix = "canh_rau_den-"
  instance_type = "t2.micro"
  image_id = "ami-0ee0b284267ea6cde" //ubuntu 16.04 LTS
  key_name  = "${var.key_name}" //from ec2 module
  user_data = "${(data.template_file.bootstrap.rendered)}"
  security_groups = ["${var.security_group}"] // using security group from VPC module
  enable_monitoring = true //for CPUUtilization metric policy
  
  lifecycle {
    create_before_destroy = true 
  }
}
resource "aws_autoscaling_group" "hung_auto_scaling_group" {
    name = "hung_auto_scaling_group"
    max_size                  = 4
    min_size                  = 1
    health_check_grace_period = 300
    health_check_type         = "ELB"
    desired_capacity          = 2
    launch_configuration      = "${aws_launch_configuration.hung_launch_config.name}"
    vpc_zone_identifier       = "${var.subnet_id}"
    target_group_arns         = ["${var.target_group_arn}"] // for application loadbalancer
    
    tag {
    key                 = "Name"
    value               = "Canh-Chua-Ca-Loc"
    propagate_at_launch = true
    }
}
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.hung_auto_scaling_group.name}"
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scal_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.hung_auto_scaling_group.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3 //3 time
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60   //60 s
  statistic           = "Average"
  threshold           = 90 // 90%

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.hung_auto_scaling_group.name}"
  }

  alarm_description = "Scale up if CPU utilization is above 90% for 60 seconds"
  alarm_actions     = ["${aws_autoscaling_policy.scale_up.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.hung_auto_scaling_group.name}"
  }

  alarm_description = "Scale down if CPU utilization is above 10% for 60 seconds"
  alarm_actions     = ["${aws_autoscaling_policy.scale_down.arn}"]
}
