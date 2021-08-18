resource "aws_lb_listener" "helloworld" {
  load_balancer_arn = aws_lb.helloworld.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.helloworld.arn
  }
}