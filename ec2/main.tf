provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}
data "aws_availability_zones" "available" {}

resource "aws_key_pair" "public_key" {
  key_name   = "public_key"
  public_key = "${file(var.public_key)}"
}
resource "aws_instance" "hung_terraform_ubuntu" {
  count = 2
  ami   = "ami-0ee0b284267ea6cde" //ubuntu 16.04 LTS
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.public_key.id}"
  //vpc_security_group_ids = "${aws_security_group.hung_sg.id}"
  //subnet_id = "${element{aws_subnet.public_subnet.*.id[count.index]}}"

  tags = {
    Name = "Canh-Rau-Den-${count.index +1}"
  }
}
data "template_file" "bootstrap" {
  template = "${file("bootstrap.tpl")}"
}