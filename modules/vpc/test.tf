locals { base-name-test = "test" }

# Create VPC
resource "aws_vpc" "test" {
  cidr_block           = "${local.cidr_prefix.test}.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"


  tags = {
    Name = local.base-name-test
  }
}

# Create public subnet
resource "aws_subnet" "test-sn0-public" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "${local.cidr_prefix.test}.0.0/24"
  availability_zone = local.availability-zone-1a

  tags = {
    Name = "${local.base-name-test}-sn0-public"
  }
}

# Create private subnet
resource "aws_subnet" "test-sn1-private" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "${local.cidr_prefix.test}.1.0/24"
  availability_zone = local.availability-zone-1a

  tags = {
    Name = "${local.base-name-test}-sn1-private"
  }
}

# Create GW
resource "aws_internet_gateway" "test-ig0" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "test-ig0"
  }
}

# Create EIP for NAT GW
resource "aws_eip" "test-ip0-nat" {

  tags = {
    Name = "test-ip0-nat"
  }
}

# Create NAT GW
resource "aws_nat_gateway" "test-nat0" {
  allocation_id = aws_eip.test-ip0-nat.id
  subnet_id     = aws_subnet.test-sn0-public.id

  tags = {
    Name = "test-nat0"
  }
}

# Create route table for public subnet
resource "aws_route_table" "test-rtb0-public" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-ig0.id
  }

  tags = {
    Name = "test-rtb0-public"
  }
}

# Handle default route and rename to private
resource "aws_default_route_table" "test-rtb1-private" {
  default_route_table_id = aws_vpc.test.default_route_table_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.test-nat0.id
  }

  tags = {
    Name = "test-rtb1-private"
  }
}

# Associate route table to public subnet
resource "aws_route_table_association" "test-associate-1a-r-s" {
  subnet_id      = aws_subnet.test-sn0-public.id
  route_table_id = aws_route_table.test-rtb0-public.id
}

# Associate route table to private subnet
resource "aws_route_table_association" "test-associate-r-s-private-app" {
  subnet_id      = aws_subnet.test-sn1-private.id
  route_table_id = aws_default_route_table.test-rtb1-private.id
}

resource "aws_default_network_acl" "test-default" {
  default_network_acl_id = aws_vpc.test.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${local.base-name-test}-nacl0"
  }
  lifecycle {
    ignore_changes = [subnet_ids]
  }
}
