data "aws_vpc" "prod-vpc" {
#   id = data.aws_vpc.prod-vpc.id
filter {
    name   = "tag:Name"
    values = ["PROD-VPC"] # Replace with your exact subnet name tag
  }
}

data "aws_subnet" "prod-ec2-pub-subnet01" {
  filter {
    name   = "tag:Name"
    values = ["PROD-EC2-Pub-Subnet01"] # Replace with your exact subnet name tag
  }
}

data "aws_subnet" "prod-ec2-pub-subnet02" {
  filter {
    name   = "tag:Name"
    values = ["PROD-EC2-Pub-Subnet02"] # Replace with your exact subnet name tag
  }
}

data "aws_subnet" "prod-ec2-pub-subnet03" {
  filter {
    name   = "tag:Name"
    values = ["PROD-EC2-Pub-Subnet03"] # Replace with your exact subnet name tag
  }
}

data "aws_key_pair" "dev_key_pair" {
  filter {
    name   = "tag:Name"
    values = ["DEV-PEM-KP"] 
  }
}


data "http" "my_public_ip" {
  url = "https://ifconfig.me/ip" # /ip ensures a clean text response
  
  # Optional: request plain text format explicitly
  request_headers = {
    Accept = "text/plain"
  }
}

# 3. Access the IP using '.response_body'
output "current_machine_ip" {
  value = chomp(data.http.my_public_ip.response_body)
}