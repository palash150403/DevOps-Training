resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name = var.subnet_group_name
  multi_az             = false
  publicly_accessible  = false
  tags = {
    Name = "palash-db-instance"
  }
}
