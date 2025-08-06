resource "aws_db_instance" "dr_mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "drdb"
  username             = "admin"
  password             = "password123"  # Replace in production with secret manager
  skip_final_snapshot  = true

  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.dr_sg.id]

  tags = {
    Name = "dr-mysql-db"
  }
}
