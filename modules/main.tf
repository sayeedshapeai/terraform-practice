provider "aws" {
  region = "us-east-1"
}

variable "db_identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "storage" {
  type = number
}

variable "username" {
  type = string
}

variable "password" {
  type = string
  sensitive = true
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "rds" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_db_subnet_group" "database" {
  name       = "rds-db-subnet-group"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "rds-db-subnet-group"
  }
}

module "my_database" {
  source = "../modules-rds"

  db_identifier      = "my-app-db"
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t3.micro"
  storage            = 20
  username           = "admin"
  password           = "Password123!"
  db_name            = "applicationdb"
  security_group_ids = [aws_security_group.rds.id]
  subnet_group_name  = aws_db_subnet_group.database.name
}
