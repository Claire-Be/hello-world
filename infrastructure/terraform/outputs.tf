output "ssh_host" {
  value = aws_instance.orchestrate.public_ip
}