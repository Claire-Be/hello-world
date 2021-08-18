resource "aws_lb_target_group_attachment" "web_1" {
    target_group_arn = aws_lb_target_group.helloworld.arn
    target_id = aws_instance.web_1.id
    port = 8080
}

resource "aws_lb_target_group_attachment" "web_2" {
    target_group_arn = aws_lb_target_group.helloworld.arn
    target_id = aws_instance.web_2.id
    port = 8080
}