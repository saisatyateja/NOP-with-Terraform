# Create a security group for the EC2 instance
resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2_sg_"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = "ami-064087b8d355e9051" 
  instance_type = "t2.micro"
  key_name      = "Stockholm"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker
              sudo service docker start
              sudo docker run -d --name nopcommerce -p 80:80 nopcommerce/nopcommerce
              EOF
  tags = {
    Name = "nopcommerce-ec2-instance"
  }
}

# Output the public IP address of the EC2 instance
output "ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
