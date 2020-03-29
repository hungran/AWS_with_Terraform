provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}

resource "aws_subnet" "private_subnet" {
  vpc_id = var.vpc_id
  count = length(split(",", var.private_cidr))
  cidr_block = element(split(",", var.private_cidr), count.index)
  availability_zone = element(split(",", var.availability_zone), count.index)
  map_public_ip_on_launch = false
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  lifecycle {                            
    create_before_destroy = true
  }

  tags = {
    Name = var.private_subnet_name.element(split(",", var.availability_zone), count.index)
  }
}

resource "aws_route_table" "aws_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block_ipv4
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = var.route_table_name.element(split(",", var.availability_zone), count.index)
  }
  lifecycle {                            
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count = length(split(",", var.private_cidr)
  subnet_id = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}