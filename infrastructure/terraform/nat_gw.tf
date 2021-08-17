resource "aws_nat_gateway" "helloworld" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.sub_pub_1.id
  tags = {
    Name = "helloworld_ngw"
  }
  depends_on = [aws_internet_gateway.helloworld]
}