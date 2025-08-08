resource "aws_vpc" "dr_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "dr-vpc"
  }
}

resource "aws_subnet" "dr_subnet_public" {
  vpc_id                  = aws_vpc.dr_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "dr-subnet-public"
  }
}
resource "aws_subnet" "dr_subnet_private" {
  vpc_id                  = aws_vpc.dr_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "dr-subnet-private"
  }
}
resource "aws_internet_gateway" "dr_igw" {
  vpc_id = aws_vpc.dr_vpc.id

  tags = {
    Name = "dr-igw"
  }
}

resource "aws_route_table" "dr_route_table" {
  vpc_id = aws_vpc.dr_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dr_igw.id
  }

  tags = {
    Name = "dr-rt"
  }
}

resource "aws_route_table_association" "dr_subnet_association" {
  subnet_id      = aws_subnet.dr_subnet_public.id
  route_table_id = aws_route_table.dr_route_table.id
}
