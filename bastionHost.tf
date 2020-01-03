#config provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

#creates VPC
resource "aws_vpc" "Edge" {
  cidr_block = "10.10.10.0/24"
  instance_tenancy = "dedicated"
  lifecycle {
      prevent_destroy = true
  }

  tags = {
      Name = "Edge"
  }
}





