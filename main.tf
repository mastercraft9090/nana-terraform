provider "aws" {
  region  = "us-east-1"
}
# We are going to have to make this more structured so its easy to find

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  type = string
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type = string
  
}

variable "environment" {
  description = "vpc environment"
  type = string
}

resource "aws_vpc" "main_practice_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
      Name = "main_practice_vpc"
      vpc_env = var.environment
          }
  }
 

resource "aws_subnet" "main_practice_vpc_subnet" {
  vpc_id = aws_vpc.main_practice_vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-east-1a"
}

resource "aws_instance" "test-app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "TestServerInstance"
  }
}

data "aws_vpc" "exisiting_vpc" {
  default = true
  
}

resource "aws_subnet" "default_subnet_1" {
  vpc_id = data.aws_vpc.exisiting_vpc.id
  cidr_block = "172.31.96.0/20"
  availability_zone = "us-east-1b"
  tags = {
    Name = "default_subnet_1"
  }

  
}

output "dev-vpc-id" {
  value = "${aws_vpc.main_practice_vpc.id}"  
}

# output "main_vpc_id" {
#   value = "${aws_vpc.existing_vpc.id}"
  
# }
output "dev_vpc_subnet" {
  value = "${aws_subnet.main_practice_vpc_subnet.id}"
  
}
