output "ssh_host" {
  value = aws_instance.orchestrate.public_ip
}

output "lb_dns_record" {
  value = aws_lb.helloworld.dns_name
}