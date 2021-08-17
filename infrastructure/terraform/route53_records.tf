resource "aws_route53_record" "orchestrate" {
  zone_id = aws_route53_zone.dev_private.id
  name    = "orch"
  type    = "A"
  ttl     = 300
  records = [aws_instance.orchestrate.private_ip]
}

resource "aws_route53_record" "web_1" {
  zone_id = aws_route53_zone.dev_private.id
  name    = "web-1"
  type    = "A"
  ttl     = 300
  records = [aws_instance.web_1.private_ip]
}

resource "aws_route53_record" "web_2" {
  zone_id = aws_route53_zone.dev_private.id
  name    = "web-2"
  type    = "A"
  ttl     = 300
  records = [aws_instance.web_2.private_ip]
}