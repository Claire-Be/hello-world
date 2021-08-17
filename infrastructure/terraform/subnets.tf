resource "aws_subnet" "sub_pub_1" {
  vpc_id            = aws_vpc.helloworld.id
  cidr_block        = var.vpc_subnet_cidr_blocks["pub_1"]
  availability_zone = join("", [var.region, "a"])
  tags = {
    Name = "cbeamer-sub-pub-1"
  }
}

resource "aws_subnet" "sub_pub_2" {
  vpc_id            = aws_vpc.helloworld.id
  cidr_block        = var.vpc_subnet_cidr_blocks["pub_2"]
  availability_zone = join("", [var.region, "b"])
  tags = {
    Name = "cbeamer-sub-pub-2"
  }
}

resource "aws_subnet" "sub_priv_1" {
  vpc_id            = aws_vpc.helloworld.id
  cidr_block        = var.vpc_subnet_cidr_blocks["priv_1"]
  availability_zone = join("", [var.region, "a"])
  tags = {
    Name = "cbeamer-sub-priv-1"
  }
}

resource "aws_subnet" "sub_priv_2" {
  vpc_id            = aws_vpc.helloworld.id
  cidr_block        = var.vpc_subnet_cidr_blocks["priv_2"]
  availability_zone = join("", [var.region, "b"])
  tags = {
    Name = "cbeamer-sub-priv-2"
  }
}