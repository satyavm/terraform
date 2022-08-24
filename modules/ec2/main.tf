resource "aws_instance" "web01" {
  ami                    = data.aws_ami.amazon.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.http.id]
  key_name               = aws_key_pair.ssh_key.key_name
  tags = {
    "Name" = "Web01"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
    ]
  }

}

resource "aws_security_group" "ssh" {
  name     = "ssh_SG"
  vpc_id   = data.aws_vpc.vpc.id
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }

}
data "aws_vpc" "vpc" {
  default  = true
}

resource "aws_security_group" "http" {
  name     = "http_SG"
  vpc_id   = data.aws_vpc.vpc.id
  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }

}

data "aws_ami" "amazon" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "devops"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmZ0tJW97eRv+V4YJggm0W8FKNwsKO5URZuampJTP6NvInJ+7so2sCjvJssH0IlGskCOtJBRJUk6HKlem2TTqmg1JY6XRdgHu5LYw+eRXGdkow6HPBjgsH9xkAh8kBcfaKeQ9RmHUSDOzggO7tIHGgGvZNDfXxmdzoxBdzk44ryMx5FXDu1DQR9YZv8eycaPiZOeDPxm4PlqVrP64VnhwssYgz+2PLw7wc9xQxYhzFs3ORm0QKwn7rWB50Oq7Bigh4WJgC4c/VXczzzLf9hC/3p7r2p3hwMhwh+52Rw4B142h+D4iIc6MlAErTcNFda6Id2ylQ46zejw/9BJIVag/X jenkins@ip-172-31-84-120.ec2.internal"

}