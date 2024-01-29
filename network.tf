resource "aws_vpc" "lab-vpc" {
  cidr_block = var.vpc

  tags = {
    Name = "lab-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.lab-vpc.id

  tags = {
    Name = "LAB-IGW"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.lab-vpc.id
  cidr_block              = var.netpublic
  map_public_ip_on_launch = true
  tags = {
    Name = "lab-public"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.lab-vpc.id
  cidr_block = var.netprivate
  tags = {
    Name = "lab-private"
  }
}

resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.lab-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-public"
  }

}

resource "aws_route_table_association" "rt-public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt-public.id

}


