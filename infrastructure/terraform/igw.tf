resource "aws_internet_gateway" "helloworld" {
  vpc_id = aws_vpc.helloworld.id
  tags = {
    Name = "helloworld"
  }
}