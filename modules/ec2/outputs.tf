output "web01_public_ip" {
  value = aws_instance.web01.public_ip
}

output "web01_private_ip" {
  value = aws_instance.web01.private_ip
}

output "security_grp_id" {
  value = aws_security_group.ssh.id
}