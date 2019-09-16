# Require TF version to most recent
terraform {
  required_version = "~> 0.12.8"
}

# Download any stable version in AWS provider of 2.19.0 or higher in 2.19 train
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.27.0"
}

# Build the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"

  tags = {
    Name      = "Vpc"
    Terraform = "true"
  }
}

# Build route table 1
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable1"
    Terraform = "true"
  }
}

# Build route table 2
resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable2"
    Terraform = "true"
  }
}

# Build "KylerTest" subnets
module "kyler_test_subnets" {
  source                 = "./modules/subnet"
  vpc_id                 = aws_vpc.vpc.id
  subnet_group           = "KylerTest"
  availability_zone = [
    "a",
    "c"
  ]
  subnet_addresses = [
    "10.1.10.0/24",
    "10.1.20.0/24",
    "10.1.30.0/24",
    "10.1.40.0/24",
    "10.1.50.0/24"
  ]
  route_table_id = [
    aws_route_table.route_table1.id,
    aws_route_table.route_table2.id
  ]
}
