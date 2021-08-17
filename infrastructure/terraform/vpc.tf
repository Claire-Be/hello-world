resource "aws_vpc" "helloworld" {
  cidr_block = var.vpc_cidr_block
}