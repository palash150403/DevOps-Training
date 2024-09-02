resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name       = "Palash-east1"

  tags = {
    Name = "palash-ec2"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
    "sudo apt-get update -y",
    "sudo apt-get install -y apache2",
    "sudo systemctl start apache2",
    "sudo systemctl enable apache2"
    ]

    
  }

  provisioner "local-exec" {
    command = "echo 'EC2 instance successfully provisioned with Apache.'"
  }
}
