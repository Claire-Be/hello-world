resource "aws_route53_zone" "dev_private" {
  name = "dev.private"
  vpc {
    vpc_id = aws_vpc.helloworld.id
  }
}