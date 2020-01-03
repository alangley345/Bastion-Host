#creates VPC
resource "aws_vpc" "Edge" {
  cidr_block = "10.10.10.0/24"
  instance_tenancy = "dedicated"

  tags = {
      Name = "Edge"
  }
}

#Subnet for edge devices
resource "aws_subnet" "Edge" {
  vpc_id     = "${aws_vpc.Edge}"
  cidr_block = "10.10.10.0/24"

  tags = {
    Name = "Edge"
  }
}

#Internet gateway for Edge VPC
resource "aws_internet_gateway" "Edge" {
  vpc_id = "${aws_vpc.Edge}"

  tags = {
    Name = "Edge"
  }
}

