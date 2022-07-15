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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjbiyXjNT+TAbkNHIlba2f3yGPXTxZCThSfUkOQ6kuBCEdquUTkykGvyI2979UpTlSc1GHCCLb30sWzHkeTnFLydwQgYi3yqEFpwECj32Lj+erV+nZLDrpPeR564+NTB/kgT3JCs02WkIh7h0iAFheX4zJeKdhp1H3cljMrM1bolx/HKTy7ZWJj3eIR3T2L3MgqiEJwCQrFsQst/R9M7190AxEybmu9jZjryzUsLb2rCCTPwQ5QJHjdt+9tzh6tKPQvsCfUCokWnVgQpCK0rFEYBMrbGEfhqMhFeTkYhoRPDBHivHs+tSkXthr8at3j0TpbPFBrHveXBoG1zKcmXnesx+tLK9RiMmvNXIPFsxe6xHAQia4L0CSZQW5Q5wxA8QMQM0L6ZN8H3g6EKgC7KuPLjzFpih5SXAApq+OaNvTZrB+vF24wuR7AwIKTYfARYcbYq/U3P1/UaU2lPOtAnWXeb0WRgRKtH+4LgaeotnLiLAso/J7hATgH1LHdPr94ik= saran@DESKTOP-LRRN1BK"

}