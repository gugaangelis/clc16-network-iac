output "id_vpc" {
  value = aws_vpc.clc_vpc.id
}

output "public_subnet_1a" {
  value = aws_subnet.public_subnet_1c.id
}

output "private_subnet_1a" {
  value = aws_subnet.private_subnet_1c.id
}

# output "rt_clc_vpc" {
#   value = aws_route_table.rt_clc_vpc.id
# }

output "igw_clc_vpc" {
  value = aws_internet_gateway.gw_clc_vpc.id
}