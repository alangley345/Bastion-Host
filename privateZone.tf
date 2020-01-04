#creates VPC
resource "aws_vpc" "Private" {
  cidr_block       = "10.10.10.1/24"
  instance_tenancy = "dedicated"
  tags = {
    Name = "Private"
  }
}

#Subnet for edge devices
resource "aws_subnet" "Private" {
  vpc_id     = "${aws_vpc.Private.id}"
  cidr_block = "10.10.10.1/24"
  depends_on = [aws_vpc.Private]

  tags = {
    Name = "Private"
  }
}

#security group for gateway
resource "aws_security_group" "Private" {
  name        = "Private Rules"
  description = "Allow SSH traffic to and from this subnet "
  vpc_id      = "${aws_vpc.Private.id}"

  ingress {
    # SSH from known IPs
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.10.0/24"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.10.0/24"]
  }
}
