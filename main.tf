terraform {
  required_version = ">= 1.5.6"  # Specify the minimum version required
}

provider "aws" {
  region = "us-west-2"
}
resource "aws_security_group" "sg" {
  name = "test-sg"
  description = "allow HTTP and SSH traffic"
ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [0.0.0.0/0]
}

ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
tags = {
  name = "ec2-sg"
}

}

resource "aws_instance" "ec2-test" {

  ami           = "ami-04dd23e62ed049936"
  instance_type = "t2.micro"
  count         = 1
  key_name      = "eks-cluster"
  user_data     = file("user_data.sh")
  tags = {
    name = "aws_instance_${count.index}"
  }

}
