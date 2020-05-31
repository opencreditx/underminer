provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  profile = "RobinKurosawa"
}

data "aws_ami" "aws_linux2_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "aws_linux2_allow_http_tls_ssh" {
  name        = "aws_linux2_allow_http_ssh"
  description = "Allow HTTP TLS SSH inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_ebs_volume" "ebs_default" {
  availability_zone = "us-east-1"
  size              = 64
  encrypted         = true

  tags = {
    Name = "Underminer_EBS"
  }
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.aws_linux2_ami.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.aws_linux2_allow_http_tls_ssh.name]
  key_name        = "ec2-key-0"
  user_data       = file("./startup.sh")

  tags = {
    Name = "Underminer"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_default.id
  instance_id = aws_instance.web.id
}

output "IP" {
  value = "${aws_instance.web}"
}
