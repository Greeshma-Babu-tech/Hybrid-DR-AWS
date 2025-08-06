output "instance_id" {
  value = aws_instance.dr_web.id
}

output "public_ip" {
  value = aws_instance.dr_web.public_ip
}
