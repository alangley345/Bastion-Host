resource "aws_vpc" "Edge" {
  cidr_block = "10.10.10.0/24"
  instance_tenancy = "dedicated"

  tags = {
      Name = "Edge"
  }
}
