# Security Group
resource "aws_security_group" "prod-public-remote-sg" {
  name        = "PROD-Public-Remote-SG"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.prod-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_public_ip.response_body)}/32"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_public_ip.response_body)}/32"]
    prefix_list_ids = ["pl-073f7512b7b9a2450"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "prod_webserver" {
  ami           = var.ubuntu-ami-id 
  instance_type = var.instance-type
  key_name      = data.aws_key_pair.dev_key_pair.key_name
  subnet_id     = data.aws_subnet.prod-ec2-pub-subnet01.id
  vpc_security_group_ids = [aws_security_group.prod-public-remote-sg.id]
  user_data = file("nginx.sh")
  tags = {
    Name = "PROD-Web-Server"
  }
}

resource "aws_instance" "prod_webserver-02" {
  ami           = var.ubuntu-ami-id 
  instance_type = var.instance-type
  key_name      = data.aws_key_pair.dev_key_pair.key_name
  subnet_id     = data.aws_subnet.prod-ec2-pub-subnet02.id
  vpc_security_group_ids = [aws_security_group.prod-public-remote-sg.id]
  user_data = file("nginx.sh")
  tags = {
    Name = "PROD-Web-Server-02"
  }
}
