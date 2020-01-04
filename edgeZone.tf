#config provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

#creates VPC
resource "aws_vpc" "Edge" {
  cidr_block       = "10.10.10.0/24"
  instance_tenancy = "dedicated"

  tags = {
    Name = "Edge"
  }
}

#Internet gateway for Edge VPC
resource "aws_internet_gateway" "Edge" {
  vpc_id     = "${aws_vpc.Edge.id}"
  depends_on = [aws_vpc.Edge]

  tags = {
    Name = "Edge"
  }
}

#Subnet for edge devices
resource "aws_subnet" "Edge" {
  vpc_id     = "${aws_vpc.Edge.id}"
  cidr_block = "10.10.10.0/24"
  depends_on = [aws_vpc.Edge]

  tags = {
    Name = "Edge"
  }
}

#creating aws_eip
resource "aws_eip" "edge-1" {
  lifecycle {
    prevent_destroy = true
  }
}

#creates NAT gateway
resource "aws_nat_gateway" "Edge" {
  allocation_id             ="${aws_eip.edge-1.id}"
  depends_on                = [aws_internet_gateway.Edge]
  subnet_id                 = "${aws_subnet.Edge.id}"

}

#security group for gateway
resource "aws_security_group" "Edge" {
  name        = "Edge Rules"
  description = "Allow traffic to "
  vpc_id      = "${aws_vpc.Edge.id}"

  ingress {
    # SSH from known IPs
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["38.77.49.40/32", "108.183.251.164/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  
  }
}

terraform {
  backend "s3" {
  bucket="myterraformcode"
  key="edge/terraform.tfstate"
  region="us-east-1"  
  }
}