resource "aws_instance" "orchestrate" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  user_data                   = data.template_file.cloud_init_orchestrate.rendered
  subnet_id                   = aws_subnet.sub_pub_1.id
  vpc_security_group_ids      = [aws_security_group.ssh_sg.id]
  tags = {
    Name = join("", ["orchestrator-1", "-", var.region])
  }
  provisioner "remote-exec" {
    script = "bootstrap.sh"
    connection {
      type = "ssh"
      user = var.remote_user
      host = aws_instance.orchestrate.public_ip
    }
  }
  depends_on = [aws_route53_record.web_1,
  aws_route53_record.web_2]
}

resource "aws_instance" "web_1" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  user_data                   = data.template_file.cloud_init_web.rendered
  subnet_id                   = aws_subnet.sub_priv_1.id
  vpc_security_group_ids      = [aws_security_group.service_web_sg.id]
  tags = {
    Name = join("", ["web-1", "-", var.region])
  }
}

resource "aws_instance" "web_2" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  user_data                   = data.template_file.cloud_init_web.rendered
  subnet_id                   = aws_subnet.sub_priv_2.id
  vpc_security_group_ids      = [aws_security_group.service_web_sg.id]
  tags = {
    Name = join("", ["web-2", "-", var.region])
  }
}