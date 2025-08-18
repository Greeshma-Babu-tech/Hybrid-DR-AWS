# DB Subnet Group for Private Subnets
resource "aws_db_subnet_group" "dr_db_subnet_group" {
  name       = "dr-db-subnet-group"
  subnet_ids = [var.private_subnet_id_1, var.private_subnet_id_2]

  tags = {
    Name = "dr-db-subnet-group"
  }
}
resource "aws_db_instance" "dr_mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "drdb"
  username             = "admin"
  password             = "password123"  # Replace in production with secret manager
  skip_final_snapshot  = true

  publicly_accessible = false
  #vpc_security_group_ids = [aws_security_group.dr_sg.id]
  db_subnet_group_name = aws_db_subnet_group.dr_db_subnet_group.name
  tags = {
    Name = "dr-mysql-db"
  }
}
