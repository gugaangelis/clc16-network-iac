## Criar a VPC com referencia da vpc clc_vpc_1c
resource "aws_vpc" "clc_vpc_1c" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-terraform-1c-com-remote-state"
  }
}

## Criar a Subnet Publica 1c com referencia da vpc clc_vpc_1c
resource "aws_subnet" "public_subnet_1c" {
  vpc_id            = aws_vpc.clc_vpc_1c.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "public_subnet_1c"
  }
}

## Cria a subnet privada com referencia da vpc clc_vpc_1c
resource "aws_subnet" "private_subnet_1c" {
  vpc_id            = aws_vpc.clc_vpc_1c.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "private_subnet_1c"
  }
}

## Criar o Internet Gateway com referencia da vpc clc_vpc_1c
resource "aws_internet_gateway" "gw_clc_vpc_1c" {
  vpc_id = aws_vpc.clc_vpc_1c.id
  tags = {
    Name = "igw_clc_vpc_1c"
  }
}

## Cria tabela de rota publica com rota para o Internet Gateway 1c
resource "aws_route_table" "rt_clc_vpc_1c" {
  vpc_id = aws_vpc.clc_vpc_1c.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_clc_vpc_1c.id
  }
}

## Associa a tabela de rota publica na subnet publica 1c ##
resource "aws_route_table_association" "rt_pub_association_subnet_1c" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.rt_clc_vpc_1c.id
}

## Cria um IP público para nat gateway 1c ##
resource "aws_eip" "eip_nat_gw_1c" {
  domain = "vpc"
}

## Cria tabela de rota privada 1c com rota para o NAT Gateway da 1c
resource "aws_route_table" "private_rt_1c" {
  vpc_id = aws_vpc.clc_vpc_1c.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1c.id
  }

  tags = {
    Name = "private_rt_1c_tf"
  }
}

## Associa a tabela de rota privada 1c na subnet privada 1c ##
resource "aws_route_table_association" "rt_priv_association_subnet_1c" {
  subnet_id      = aws_subnet.private_subnet_1c.id
  route_table_id = aws_route_table.private_rt_1c.id
}
