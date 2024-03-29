# Find the current AWS region to use for availability zone
data "aws_region" "current" {}

# Build subnet resource
resource "aws_subnet" "subnet" {
  count      = length(var.subnet_addresses)
  vpc_id     = var.vpc_id
  cidr_block = element(var.subnet_addresses, count.index)
  availability_zone = "${data.aws_region.current.name}${element(var.availability_zone, count.index)}"

  tags = {
    Terraform = "true"
    Name      = "${var.subnet_group}Subnet${count.index + 1}"
  }
}

# Associate subnet to route table
resource "aws_route_table_association" "subnet_route_table_association" {
  count          = length(var.subnet_addresses)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = element(var.route_table_id, count.index)
}
