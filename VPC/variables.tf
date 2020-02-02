variable "vpc_cidr" {
  default = "192.168.0.0/16"
}
variable "public_cidrs" {
  type = list
  default = ["192.168.1.0/24", "192.168.2.0/24"]
}
variable "private_cidrs" {
  type = list
  default = ["192.168.253.0/24", "192.168.254.0/24"]
}
