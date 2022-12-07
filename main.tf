terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.55.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "subnet-public-signalr-core" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-public-signalr-core"
  }
}



resource "aws_lb_target_group" "tg-app-ecs-signalr-core" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "tg-app-ecs-signalr-core"
  }
}


resource "aws_instance" "personal_website" {
    ami = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
}

