provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "aws_instance" "dev" {
  count = 3
  ami = "ami-coloquesuaami"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["sg-seusecuritygroup"]
}

resource "aws_security_group" "acesso-ssh" {
  name = "acesso-ssh"
  description = "acesso-ssh"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["191.32.154.79/32"]
  }
  tags = {
    Name = "ssh"
  }
}