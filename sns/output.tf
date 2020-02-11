output "sns_arn" {
  value = "${aws_sns_topic.hung-alarm.arn}"
}