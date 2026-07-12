output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "private_rt" {
  value = aws_route_table.private_rt.id
}