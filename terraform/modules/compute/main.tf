resource "aws_instance" "dr_web" {
  ami                         = "ami-020cba7c55df1f615" # Canonical, Ubuntu, 24.04, amd64 noble image
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.dr_subnet.id
  vpc_security_group_ids      = [aws_security_group.dr_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

  tags = {
    Name = "dr-web-server"
  }
}
