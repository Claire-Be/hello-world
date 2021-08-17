resource "aws_route_table_association" "pub_1" {
  subnet_id      = aws_subnet.sub_pub_1.id
  route_table_id = aws_route_table.pub_1.id
}

resource "aws_route_table_association" "pub_2" {
  subnet_id      = aws_subnet.sub_pub_2.id
  route_table_id = aws_route_table.pub_2.id
}

resource "aws_route_table_association" "priv_1" {
  subnet_id      = aws_subnet.sub_priv_1.id
  route_table_id = aws_route_table.priv_1.id
}

resource "aws_route_table_association" "priv_2" {
  subnet_id      = aws_subnet.sub_priv_2.id
  route_table_id = aws_route_table.priv_2.id
}