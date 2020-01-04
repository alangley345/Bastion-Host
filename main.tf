#config provider
provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "myterraformcode"
    key    = "bastionhost/bastionhost.tfstate"
    region = "us-east-1"
  }
}
