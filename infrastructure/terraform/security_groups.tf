## Allow HTTP connections from the internet
resource "aws_security_group" "lb_web_sg" {
  name        = "lb_web_sg"
  description = "Allow web connections via ALB"
  vpc_id      = aws_vpc.helloworld.id
  ingress {
    description = "HTTP web connections"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Only allow HTTP connections from loadbalancer security group
resource "aws_security_group" "service_web_sg" {
  name        = "service_web_sg"
  description = "Allow web connections from ALB security group"
  vpc_id      = aws_vpc.helloworld.id
  ingress {
    description     = join("", ["HTTP web connections from ", aws_security_group.lb_web_sg.id])
    from_port       = 8080
    to_port         = 8080
    protocol        = "TCP"
    security_groups = [aws_security_group.lb_web_sg.id]
  }
  ingress {
    description     = join("", ["Allow SSH connections from ", aws_security_group.ssh_sg.id])
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.ssh_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Allow SSH
resource "aws_security_group" "ssh_sg" {
  name        = "ssh_sg"
  description = "Allow SSH connections"
  vpc_id      = aws_vpc.helloworld.id
  ingress {
    description = "Allow SSH connections"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}