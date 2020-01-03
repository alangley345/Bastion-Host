#config provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

#creates VPC
resource "aws_vpc" "Edge" {
  cidr_block = "10.10.10.0/24"
  instance_tenancy = "dedicated"
  prevent_destroy = true

  tags = {
      Name = "Edge"
  }
}

#Subnet for edge devices
resource "aws_subnet" "Edge" {
  vpc_id     = "aws_vpc.Edge"
  cidr_block = "10.10.10.0/24"
  prevent_destroy = true

  tags = {
    Name = "Edge"
  }
}

#Internet gateway for Edge VPC
resource "aws_internet_gateway" "Edge" {
  vpc_id = "aws_vpc.Edge"
  prevent_destroy = true

  tags = {
    Name = "Edge"
  }
}


