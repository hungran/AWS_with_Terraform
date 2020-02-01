provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "hung_vpc_2020" {
  cidr_block            = "${var.vpc_cidr}"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = "hung_test_vpc_by_terraform"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id             = "${aws_vpc.hung_vpc_2020.id}" 

  tags = {
    Name = "hung_test_igw"
  } 
}

resource "aws_route_table" "public_route" {
  vpc_id                = "${aws_vpc.hung_vpc_2020.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name =  "public_route"
  }
}

//Create private route table, do NOT add default route to internet gateway
resource "aws_default_route_table" "private_route" {
  default_route_table_id = "${aws_vpc.hung_vpc_2020.default_route_table_id}"
  
  tags = {
    Name = "private_route"
  }
}

//Create public subnet
resource "aws_subnet" "public_subnet" {
  count                   = 2
  cidr_block              = "${var.public_cidrs[count.index]}"
  vpc_id                  = "${aws_vpc.hung_vpc_2020.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  
  tags = {
    Name = "public_subnet.${count.index+1}"
  }
}
//Create private subnet
resource "aws_subnet" "private_subnet" {
  count             = 2
  cidr_block        = "${var.private_cidrs[count.index]}"
  vpc_id            = "${aws_vpc.hung_vpc_2020.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "my-test-private-subnet.${count.index + 1}"
  }
}
//Associate route table to subnet

//Associate route with Public Subnet
resource "aws_route_table_association" "public_subnet_assoc" {
  count             = 2
  route_table_id    = "${aws_route_table.public_route.id}"
  subnet_id         = "${aws_subnet.public_subnet.*.id[count.index]}"
  depends_on        = ["aws_route_table.public_route", "aws_subnet.public_subnet"]
  
}
//Associate route with Private Subnet
resource "aws_route_table_association" "private_subnet_assoc" {
  count             = 2
  route_table_id    = "${aws_route_table.private_route.id}"
  subnet_id         = "${aws_subnet.private_subnet.*.id[count.index]}"
  depends_on        = ["aws_route_table.private_route", "aws_subnet.private_subnet"]
}

//Security group
resource "aws_security_group" "hung_sg_2020" {
  name = "hung_sg_2020"
  vpc_id = "${aws_vpc.hung_vpc_2020.id}"
}

//allow ssh
resource "aws_security_group_rule" "allow-ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.hung_sg_2020}"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["14.162.187.38/32"]  //my ip
  
}
//allow web 80
resource "aws_security_group_rule" "allow-web" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.hung_sg_2020}"
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["14.162.187.38/32"]  //my ip
  
}
//allow outbound
resource "aws_security_group_rule" "allow-outbound" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.my-test-sg.id}"
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

#import key pair generate on prem
resource "aws_key_pair" "hung" {
  key_name   = "hung"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA1Jy1w8BSeJoKIPpWmMIjSStZdmSyreJbp72MXu7ltNiGke4qJGMYfPMM5vNQvNBJuA6Ra/C2wjF7IbsDMwVbxynaaglj1ECSbYF/b8xgXqpChhSERjtl/VTEJxFgp/HkvhRuXYxfFT2W9OTJATqd8BdxtJ4l+zWpVaArSJ2Ex4o+yLzWLGjOaEyabl/33sxKQUAk67iSTfEVeYRs6S1EMLMeV5p19GGQN7Jlmv3s3rbup26bk42n5SKt4rVppe17ZP1LlzKLrl/+WRhrsDMNjIngJ7HLv+S+q8E52iVN+E5cMxSnFjIaC2kI9Tig/v9+bhmqnwyxcwWKVcJJKl8uqQ=="
}
