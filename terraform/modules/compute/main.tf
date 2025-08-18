resource "aws_instance" "dr_web" {
  ami                         = "ami-020cba7c55df1f615" # Canonical, Ubuntu, 24.04, amd64 noble image
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile = var.instance_profile_name
  
  tags = {
    Name = "dr-web-server"
  }
}
