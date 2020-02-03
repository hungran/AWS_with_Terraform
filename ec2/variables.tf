variable "public_key" {
  default = ".ssh/public_key"  
}
variable "security_group" {
  default = "sg-0f7fd94bcc02ee8f6"
}
variable "subnets" {
  default = ["192.168.1.0/24", "192.168.2.0/24"]
}
