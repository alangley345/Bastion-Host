resource "aws_default_network_acl" "Edge" {
  default_network_acl_id = aws_vpc.Edge.default_network_acl_id
  depends_on             = [aws_vpc.Edge]

  #egress rules
  egress {
    rule_no = 100
    protocol = "icmp"
    from_port = -1
    to_port   = -1
    icmp_type = -1
    icmp_code = -1
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }

  egress {
    protocol   = "-1"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  #ingress rule
  ingress {
    rule_no = 100
    protocol = "icmp"
    from_port = -1
    to_port   = -1
    icmp_type = -1
    icmp_code = -1
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }


  ingress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

}
