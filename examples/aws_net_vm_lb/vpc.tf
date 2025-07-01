
resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
  tags       = { Name = "${local.project}-vpc" }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
  tags                    = { Name = "${local.project}-subnet-1" }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true
  tags                    = { Name = "${local.project}-subnet-2" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${local.project}-igw" }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.project}-rtb"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt.id
}
