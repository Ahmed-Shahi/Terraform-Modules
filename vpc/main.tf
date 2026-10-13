# VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support      = true
  enable_dns_hostnames    = true
  tags = {
    Name = "PROD-VPC"
  }
}


// Subnet
resource "aws_subnet" "prod-ec2-pub-subnet01" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PROD-EC2-Pub-Subnet01"
  }
}

resource "aws_subnet" "prod-ec2-pub-subnet02" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "PROD-EC2-Pub-Subnet02"
  }
}

resource "aws_subnet" "prod-ec2-pub-subnet03" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-southeast-1c"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "PROD-EC2-Pub-Subnet03"
  }
}

// Internet Gateway
resource "aws_internet_gateway" "prod-ec2-igw" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "PROD-EC2-IGW"
  }
}

// Route Table
resource "aws_route_table" "prod-ec2-rt" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "PROD-EC2-RT"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-ec2-igw.id
  }
}

// Route Table Association
resource "aws_route_table_association" "prod-ec2-rt-assoc01" {
  subnet_id      = aws_subnet.prod-ec2-pub-subnet01.id
  route_table_id = aws_route_table.prod-ec2-rt.id
}

resource "aws_route_table_association" "prod-ec2-rt-assoc02" {
  subnet_id      = aws_subnet.prod-ec2-pub-subnet02.id
  route_table_id = aws_route_table.prod-ec2-rt.id
}

resource "aws_route_table_association" "prod-ec2-rt-assoc03" {
  subnet_id      = aws_subnet.prod-ec2-pub-subnet03.id
  route_table_id = aws_route_table.prod-ec2-rt.id
}