resource "aws_subnet" "public_subnet" {
  vpc_id    =  aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public Subnet "
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id    =  aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id    =  aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id    =  aws_vpc.main.id
  
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id       = aws_subnet.public_subnet.id
  route_table_id  = aws_route_table.public.id 
}

resource "aws_instance" "web_server" {
  ami             = "ami-023e152801ee4846a"
  instance_type   = "t2.micro" 
  subnet_id       = aws_subnet.public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.ssh_access.id
  
  ]

}

resource "aws_security_group" "ssh_access" {
  name_prefix   = "ssh_access"
  vpc_id     = aws_vpc.main.id


  ingress {
    from_port   = 22 
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
  from_port     = 80 
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  resource "aws_eip" "aws_eip" {
  instance = aws_instance.web_server.id

  tags = {
    Name = "test-aws_eip"
  }
}
