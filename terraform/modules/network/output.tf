output "vpc_id" {
  value = aws_vpc.dr_vpc.id
}

output "dr_subnet_public" {
  value = aws_subnet.dr_subnet_public.id
}
output "dr_subnet_private_1" {
  value = aws_subnet.dr_subnet_private_1.id
}
output "dr_subnet_private_2" {
  value = aws_subnet.dr_subnet_private_2.id
}
