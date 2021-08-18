resource "aws_lb" "helloworld" {
    name = "helloworld-tf"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lb_web_sg.id]
    subnets = [aws_subnet.sub_pub_1.id, aws_subnet.sub_pub_2.id]
}