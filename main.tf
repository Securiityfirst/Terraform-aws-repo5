
terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
}

variable "aws_instance" {
    type = string
}

variable "instance_id" {
    type = string
}

variable "network_interface_id" {
    type = string
}

variable "aws_region" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "subnet_id" {
    type = string
} 

variable "key_name" {
    type = string
}

resource "aws_default_vpc" "default" {
assign_generated_ipv6_cidr_block = true
}

resource "aws_security_group" "sg" {
   name        = "security_group"
   description = "Allow Web inbound traffic"
   vpc_id      = aws_default_vpc.default.id
   ingress {
     description = "HTTPS"
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
     description = "HTTP"
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
     description = "SSH"
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
     Name = "security_group"
   }
 }

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.3.20240131.0-kernel-6.1-x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"] # Canonical
}

resource "aws_iam_role" "prod_role" {
  name = "prod_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "prod_profile" {
  name = "prod_profile"
  role = "${aws_iam_role.prod_role.name}"
}

resource "aws_iam_role_policy" "prod_policy" {
  name = "prod_policy"
  role = "${aws_iam_role.prod_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
     }
  ]
}
EOF
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = "t2.xlarge" 
  key_name        = var.key_name
  iam_instance_profile = "${aws_iam_instance_profile.prod_profile.name}"
  security_groups = [aws_security_group.sg.name]
  user_data       = "${file("install_apache2.sh")}"
  tags = {
    Name = "Apache2_server"
  }
}

resource "aws_vpc" "default" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_eip" "one" {
   network_interface         = aws_network_interface.ni.id
 }

resource "aws_network_interface" "ni" {
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.sg.id]

  attachment {
    instance     = var.aws_instance
    device_index = 1
  }
}
