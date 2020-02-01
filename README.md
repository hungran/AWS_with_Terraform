# AWS_with_Terraform
# Day2 [VPC](http://100daysofdevops.com/21-days-of-aws-using-terraform-day-2-building-aws-vpc-using-terraform/)
- * Network Access Control List(NACL)
- * Security Group
- * Route Table

- * Internet Gateways
- * Subnets
- * Custom Route Table

- Result
    plan:

            Refreshing Terraform state in-memory prior to plan...
                The refreshed state will be used to calculate this plan, but will not be
                persisted to local or remote state storage.

                data.aws_availability_zones.available: Refreshing state...

                ------------------------------------------------------------------------

                An execution plan has been generated and is shown below.
                Resource actions are indicated with the following symbols:
                + create

                Terraform will perform the following actions:

                # aws_default_route_table.private_route will be created
                + resource "aws_default_route_table" "private_route" {
                    + default_route_table_id = (known after apply)
                    + id                     = (known after apply)
                    + owner_id               = (known after apply)
                    + route                  = (known after apply)
                    + tags                   = {
                        + "Name" = "private_route"
                        }
                    + vpc_id                 = (known after apply)
                    }

                # aws_internet_gateway.igw will be created
                + resource "aws_internet_gateway" "igw" {
                    + id       = (known after apply)
                    + owner_id = (known after apply)
                    + tags     = {
                        + "Name" = "hung_test_igw"
                        }
                    + vpc_id   = (known after apply)
                    }

                # aws_key_pair.hung will be created
                + resource "aws_key_pair" "hung" {
                    + fingerprint = (known after apply)
                    + id          = (known after apply)
                    + key_name    = "hung"
                    + key_pair_id = (known after apply)
                    + public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA1Jy1w8BSeJoKIPpWmMIjSStZdmSyreJbp72MXu7ltNiGke4qJGMYfPMM5vNQvNBJuA6Ra/C2wjF7IbsDMwVbxynaaglj1ECSbYF/b8xgXqpChhSERjtl/VTEJxFgp/HkvhRuXYxfFT2W9OTJATqd8BdxtJ4l+zWpVaArSJ2Ex4o+yLzWLGjOaEyabl/33sxKQUAk67iSTfEVeYRs6S1EMLMeV5p19GGQN7Jlmv3s3rbup26bk42n5SKt4rVppe17ZP1LlzKLrl/+WRhrsDMNjIngJ7HLv+S+q8E52iVN+E5cMxSnFjIaC2kI9Tig/v9+bhmqnwyxcwWKVcJJKl8uqQ=="
                    }

                # aws_route_table.public_route will be created
                + resource "aws_route_table" "public_route" {
                    + id               = (known after apply)
                    + owner_id         = (known after apply)
                    + propagating_vgws = (known after apply)
                    + route            = [
                        + {
                            + cidr_block                = "0.0.0.0/0"
                            + egress_only_gateway_id    = ""
                            + gateway_id                = (known after apply)
                            + instance_id               = ""
                            + ipv6_cidr_block           = ""
                            + nat_gateway_id            = ""
                            + network_interface_id      = ""
                            + transit_gateway_id        = ""
                            + vpc_peering_connection_id = ""
                            },
                        ]
                    + tags             = {
                        + "Name" = "public_route"
                        }
                    + vpc_id           = (known after apply)
                    }

                # aws_route_table_association.private_subnet_assoc[0] will be created
                + resource "aws_route_table_association" "private_subnet_assoc" {
                    + id             = (known after apply)
                    + route_table_id = (known after apply)
                    + subnet_id      = (known after apply)
                    }

                # aws_route_table_association.private_subnet_assoc[1] will be created
                + resource "aws_route_table_association" "private_subnet_assoc" {
                    + id             = (known after apply)
                    + route_table_id = (known after apply)
                    + subnet_id      = (known after apply)
                    }

                # aws_route_table_association.public_subnet_assoc[0] will be created
                + resource "aws_route_table_association" "public_subnet_assoc" {
                    + id             = (known after apply)
                    + route_table_id = (known after apply)
                    + subnet_id      = (known after apply)
                    }

                # aws_route_table_association.public_subnet_assoc[1] will be created
                + resource "aws_route_table_association" "public_subnet_assoc" {
                    + id             = (known after apply)
                    + route_table_id = (known after apply)
                    + subnet_id      = (known after apply)
                    }

                # aws_security_group.hung_sg will be created
                + resource "aws_security_group" "hung_sg" {
                    + arn                    = (known after apply)
                    + description            = "Managed by Terraform"
                    + egress                 = (known after apply)
                    + id                     = (known after apply)
                    + ingress                = (known after apply)
                    + name                   = "hung_sg"
                    + owner_id               = (known after apply)
                    + revoke_rules_on_delete = false
                    + vpc_id                 = (known after apply)
                    }

                # aws_security_group_rule.allow-outbound will be created
                + resource "aws_security_group_rule" "allow-outbound" {
                    + cidr_blocks              = [
                        + "0.0.0.0/0",
                        ]
                    + from_port                = 0
                    + id                       = (known after apply)
                    + protocol                 = "-1"
                    + security_group_id        = (known after apply)
                    + self                     = false
                    + source_security_group_id = (known after apply)
                    + to_port                  = 0
                    + type                     = "egress"
                    }

                # aws_security_group_rule.allow-ssh will be created
                + resource "aws_security_group_rule" "allow-ssh" {
                    + cidr_blocks              = [
                        + "14.162.187.38/32",
                        ]
                    + from_port                = 22
                    + id                       = (known after apply)
                    + protocol                 = "tcp"
                    + security_group_id        = (known after apply)
                    + self                     = false
                    + source_security_group_id = (known after apply)
                    + to_port                  = 22
                    + type                     = "ingress"
                    }

                # aws_security_group_rule.allow-web will be created
                + resource "aws_security_group_rule" "allow-web" {
                    + cidr_blocks              = [
                        + "14.162.187.38/32",
                        ]
                    + from_port                = 80
                    + id                       = (known after apply)
                    + protocol                 = "tcp"
                    + security_group_id        = (known after apply)
                    + self                     = false
                    + source_security_group_id = (known after apply)
                    + to_port                  = 80
                    + type                     = "ingress"
                    }

                # aws_subnet.private_subnet[0] will be created
                + resource "aws_subnet" "private_subnet" {
                    + arn                             = (known after apply)
                    + assign_ipv6_address_on_creation = false
                    + availability_zone               = "ap-southeast-1a"
                    + availability_zone_id            = (known after apply)
                    + cidr_block                      = "192.168.253.0/24"
                    + id                              = (known after apply)
                    + ipv6_cidr_block                 = (known after apply)
                    + ipv6_cidr_block_association_id  = (known after apply)
                    + map_public_ip_on_launch         = false
                    + owner_id                        = (known after apply)
                    + tags                            = {
                        + "Name" = "my-test-private-subnet.1"
                        }
                    + vpc_id                          = (known after apply)
                    }

                # aws_subnet.private_subnet[1] will be created
                + resource "aws_subnet" "private_subnet" {
                    + arn                             = (known after apply)
                    + assign_ipv6_address_on_creation = false
                    + availability_zone               = "ap-southeast-1b"
                    + availability_zone_id            = (known after apply)
                    + cidr_block                      = "192.168.254.0/24"
                    + id                              = (known after apply)
                    + ipv6_cidr_block                 = (known after apply)
                    + ipv6_cidr_block_association_id  = (known after apply)
                    + map_public_ip_on_launch         = false
                    + owner_id                        = (known after apply)
                    + tags                            = {
                        + "Name" = "my-test-private-subnet.2"
                        }
                    + vpc_id                          = (known after apply)
                    }

                # aws_subnet.public_subnet[0] will be created
                + resource "aws_subnet" "public_subnet" {
                    + arn                             = (known after apply)
                    + assign_ipv6_address_on_creation = false
                    + availability_zone               = "ap-southeast-1a"
                    + availability_zone_id            = (known after apply)
                    + cidr_block                      = "192.168.1.0/24"
                    + id                              = (known after apply)
                    + ipv6_cidr_block                 = (known after apply)
                    + ipv6_cidr_block_association_id  = (known after apply)
                    + map_public_ip_on_launch         = true
                    + owner_id                        = (known after apply)
                    + tags                            = {
                        + "Name" = "public_subnet.1"
                        }
                    + vpc_id                          = (known after apply)
                    }

                # aws_subnet.public_subnet[1] will be created
                + resource "aws_subnet" "public_subnet" {
                    + arn                             = (known after apply)
                    + assign_ipv6_address_on_creation = false
                    + availability_zone               = "ap-southeast-1b"
                    + availability_zone_id            = (known after apply)
                    + cidr_block                      = " 192.168.2.0/24"
                    + id                              = (known after apply)
                    + ipv6_cidr_block                 = (known after apply)
                    + ipv6_cidr_block_association_id  = (known after apply)
                    + map_public_ip_on_launch         = true
                    + owner_id                        = (known after apply)
                    + tags                            = {
                        + "Name" = "public_subnet.2"
                        }
                    + vpc_id                          = (known after apply)
                    }

                # aws_vpc.hung_vpc_2020 will be created
                + resource "aws_vpc" "hung_vpc_2020" {
                    + arn                              = (known after apply)
                    + assign_generated_ipv6_cidr_block = false
                    + cidr_block                       = "192.168.0.0/16"
                    + default_network_acl_id           = (known after apply)
                    + default_route_table_id           = (known after apply)
                    + default_security_group_id        = (known after apply)
                    + dhcp_options_id                  = (known after apply)
                    + enable_classiclink               = (known after apply)
                    + enable_classiclink_dns_support   = (known after apply)
                    + enable_dns_hostnames             = true
                    + enable_dns_support               = true
                    + id                               = (known after apply)
                    + instance_tenancy                 = "default"
                    + ipv6_association_id              = (known after apply)
                    + ipv6_cidr_block                  = (known after apply)
                    + main_route_table_id              = (known after apply)
                    + owner_id                         = (known after apply)
                    + tags                             = {
                        + "Name" = "hung_test_vpc_by_terraform"
                        }
                    }

                Plan: 17 to add, 0 to change, 0 to destroy.

                Warning: Interpolation-only expressions are deprecated

                on main.tf line 9, in resource "aws_vpc" "hung_vpc_2020":
                9:   cidr_block            = "${var.vpc_cidr}"

                Terraform 0.11 and earlier required all non-constant expressions to be
                provided via interpolation syntax, but this pattern is now deprecated. To
                silence this warning, remove the "${ sequence from the start and the }"
                sequence from the end of this expression, leaving just the inner expression.

                Template interpolation syntax is still used to construct strings from
                expressions when the template includes multiple interpolation sequences or a
                mixture of literal strings and interpolations. This deprecation applies only
                to templates that consist entirely of a single interpolation sequence.

                (and 18 more similar warnings elsewhere)


                Warning: Quoted references are deprecated

                on main.tf line 79, in resource "aws_route_table_association" "public_subnet_assoc":
                79:   depends_on        = ["aws_route_table.public_route", "aws_subnet.public_subnet"]

                In this context, references are expected literally rather than in quotes.
                Terraform 0.11 and earlier required quotes, but quoted references are now
                deprecated and will be removed in a future version of Terraform. Remove the
                quotes surrounding this reference to silence this warning.

                (and 3 more similar warnings elsewhere)


                ------------------------------------------------------------------------

                Note: You didn't specify an "-out" parameter to save this plan, so Terraform
                can't guarantee that exactly these actions will be performed if
                "terraform apply" is subsequently run.