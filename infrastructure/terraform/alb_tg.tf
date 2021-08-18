resource "aws_lb_target_group" "helloworld" {
  name        = "helloworld-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.helloworld.id
  depends_on  = [aws_instance.orchestrate]
}