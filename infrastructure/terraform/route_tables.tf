## Public subnet route
resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.helloworld.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.helloworld.id
  }
}

## Private subnet route
resource "aws_route_table" "ngw" {
  vpc_id = aws_vpc.helloworld.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.helloworld.id
  }
}