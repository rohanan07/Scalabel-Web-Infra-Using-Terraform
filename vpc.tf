resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    name = "main-vpc"
  }
}

resource "aws_subnet" "public-subnets" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private-subnets" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "nat_gateways" {
  count = 2
  allocation_id = aws_eip.main[count.index].id
  subnet_id = aws_subnet.public-subnets[count.index].id
  depends_on = [ aws_internet_gateway.main_igw ]
}

resource "aws_eip" "main" {
  count = 2
  domain = "vpc"
  depends_on = [aws_internet_gateway.main_igw]
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    name = "public-rt-two-tier"
  }
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main_igw.id
}

resource "aws_route_table_association" "public-rt-assc" {
  count =2
  subnet_id = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table" "private-rt" {
  count = 2
  vpc_id = aws_vpc.main.id
  tags = {
    name = "private-rt-two-tier"
  }
}

resource "aws_route" "private_route" {
  count = 2
  route_table_id = aws_route_table.private-rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat_gateways[count.index].id
}

resource "aws_route_table_association" "private-rt-assc" {
  count = 2
  subnet_id = aws_subnet.private-subnets[count.index].id
  route_table_id = aws_route_table.private-rt[count.index].id
}