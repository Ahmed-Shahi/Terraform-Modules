variable "ubuntu-ami-id" {
  type = string
  default = "ami-0532913178263be11"
}

variable "instance-type" {
  type = string
  default = "t3.micro"
}

variable "my-ip" {
  type = string
  default = "$chomp(data.local_command.get_ip.stdout)/32"
}