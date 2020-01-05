#creates VPC
resource "aws_vpc" "Edge" {
  cidr_block       = "10.10.10.0/24"
  instance_tenancy = "default"
  tags = {
    Name = "Edge"
  }
}

#Subnet for edge devices
resource "aws_subnet" "Edge" {
  vpc_id     = aws_vpc.Edge.id
  cidr_block = "10.10.10.0/24"
  depends_on = [aws_vpc.Edge]
  tags = {
    Name = "Edge"
  }
}

#Internet gateway for Edge VPC
resource "aws_internet_gateway" "Edge" {
  vpc_id     = aws_vpc.Edge.id
  depends_on = [aws_vpc.Edge]
  tags = {
    Name = "Edge"
  }
}

#creating aws_eip
resource "aws_eip" "Edge" {
  instance   = aws_instance.edge.id
  depends_on = [aws_internet_gateway.Edge, aws_instance.edge]
  vpc        = true
}

#create route table for VPC
resource "aws_route_table" "Edge" {
  vpc_id = aws_vpc.Edge.id
  depends_on   = [aws_internet_gateway.Edge, aws_vpc.Edge]
  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.Edge.id
  }

  tags = {
    Name = "Edge"
  }
}

resource "aws_main_route_table_association" "Edge" {
  vpc_id         = aws_vpc.Edge.id
  route_table_id = aws_route_table.Edge.id
}


#security group for bastion host
resource "aws_security_group" "Edge" {
  name        = "Edge Rules"
  description = "Allow SSH traffic into Edge"
  vpc_id      = aws_vpc.Edge.id
  depends_on = [aws_internet_gateway.Edge]
  
  # SSH from all
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Outbound All
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #allow ICMP
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #allow ICMP
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

#set up edge instance
resource "aws_instance" "edge" {
  ami                    = "ami-00068cd7555f543d5"
  instance_type          = "t2.micro"
  key_name               = "x1Carbon"
  subnet_id              = aws_subnet.Edge.id
  vpc_security_group_ids = [aws_security_group.Edge.id]
  depends_on             = [aws_subnet.Edge, aws_security_group.Edge]
}
