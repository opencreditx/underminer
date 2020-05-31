provider "aws" {
  version = "~> 2.0"

  region  = "us-east-1"
  profile = "RobinKurosawa"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_instance" "backend_micro" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
