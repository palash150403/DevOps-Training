resource "aws_instance" "web" {
  count = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  associate_public_ip_address = true
  security_groups = [var.security_group_id]
  
  tags = {
    Name = "palash-web-instance-${count.index + 1}"
  }
}

resource "aws_eip" "web" {
  count = var.instance_count
  instance = aws_instance.web[count.index].id
}
