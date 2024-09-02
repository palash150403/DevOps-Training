resource "aws_db_subnet_group" "palash_db_subnet_group" {
  name       = "palash-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  tags = {
    Name = "palash-db-subnet-group"
  }
}

resource "aws_db_instance" "palash_rds" {
  identifier           = "palash-rds"
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = "admin"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.palash_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot  = true

  tags = {
    Name = "palash-rds"
  }
}
