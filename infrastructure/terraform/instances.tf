resource "aws_instance" "orchestrate" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  user_date                   = file("cloudinit/orchestrate.yml")
  subnet                      = aws_subnet.sub_pub_1.id
  vpc_security_groups         = [aws_security_group.ssh.id]

}

resource "aws_instance" "web_1" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  user_date                   = file("cloudinit/web.yml")
  subnet                      = aws_subnet.sub_priv_1.id
  vpc_security_groups         = [aws_security_group.service_web_sg.id]
}

resource "aws_instance" "web_2" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  user_date                   = file("cloudinit/web.yml")
  subnet                      = aws_subnet.sub_priv_2.id
  vpc_security_groups         = [aws_security_group.service_web_sg.id]
}