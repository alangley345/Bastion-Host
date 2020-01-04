resource "aws_default_network_acl" "Edge" {
  default_network_acl_id = "aws_vpc.Edge.default_network_acl_id"
  depends_on             = ["aws_vpc.Edge"]

  #egress rules
  egress {
    protocol   = "tcp"
    rule_no    = 1
    action     = "allow"
    cidr_block = "38.77.49.40/32"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    rule_no    = 2
    action     = "allow"
    cidr_block = "108.183.251.164/32"
    from_port  = 22
    to_port    = 22
  }

  #ingress rule
  ingress {
    protocol   = "tcp"
    rule_no    = 1
    action     = "allow"
    cidr_block = "38.77.49.40/32"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 2
    action     = "allow"
    cidr_block = "108.183.251.164/32"
    from_port  = 22
    to_port    = 22
  }
}

