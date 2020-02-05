provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}
data "aws_availability_zones" "available" {}
resource "aws_key_pair" "public_key" {
  key_name   = "public_key"
  public_key = "${file(var.public_key)}"
}
data "template_file" "bootstrap" {
  template = "${file("./bootstrap.tpl")}"
}
resource "aws_instance" "hung_terraform_ubuntu" {
  count = 2
  ami   = "ami-0ee0b284267ea6cde" //ubuntu 16.04 LTS
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.public_key.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id = "${element(var.subnets, count.index )}"
  user_data = "${(data.template_file.bootstrap.rendered)}"
  delete_on_termination = true
  tags = {
    Name = "Canh-Rau-Den-${count.index +1}"
  }
}
resource "aws_ebs_volume" "hung-ebs" {
  count       = 2
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}" // query lần lượt và tạo 2 ebs lần lượt vào 2 Available AZ
  size = 1 // GiB
  type = "gp2"
  
  tags = {
    Name = "hung-ebs-${count.index +1}"
  }
}
//attach volume vào instance
resource "aws_volume_attachment" "ebs-vol-attach" {
  count = 2
  device_name = "/dev/xvdh"
  instance_id = "${aws_instance.hung_terraform_ubuntu.*.id[count.index]}" //attach lần lượt vào 2 instance vừa được tạo
  volume_id = "${aws_ebs_volume.hung-ebs.*.id[count.index]}"
  depends_on = ["aws_ebs_volume.hung-ebs", "aws_instance.hung_terraform_ubuntu"]
  
}
