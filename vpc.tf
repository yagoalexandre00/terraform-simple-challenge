resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "my-public-subnet"
  }
}

resource "aws_security_group" "allow_icmp" {
  name        = "allow_icmp"
  description = "Allow ICMP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "allow_icmp"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_inbound_ipv4" {
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.allow_icmp.id
  from_port         = 22
  ip_protocol       = "TCP"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_ssh_outbound_ipv4" {
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.allow_icmp.id
  from_port         = 22
  ip_protocol       = "TCP"
  to_port           = 22
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "project-internet-gateway"
  }
}