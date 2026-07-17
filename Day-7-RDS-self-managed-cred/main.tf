resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
tags = {
    Name = "dev"
  }
}
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "my-igw"
  }
}
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}   
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.subnet-1.id 
  route_table_id = aws_route_table.name.id
}
resource "aws_route_table_association" "name-2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.name.id
}
 
resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-subnet"
  }
}
resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "my-subnet-2"    
  }
}
resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "My security group"
  vpc_id      = aws_vpc.name.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  
  resource "aws_db_subnet_group" "my_subnet_group" {
    name       = "my_subnet_group"
    subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
  }


 resource "aws_db_instance" "my_db_instance" {
  identifier              = "my-db-instance"
  allocated_storage       = 20
  max_allocated_storage   = 20

  engine                  = "mysql"
  engine_version          = "8.0"

  instance_class          = "db.t3.micro"

  db_name                 = "mydb"
  username                = "admin"
  password                = "YourStrongPassword123!"

  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false

  backup_retention_period = 1

  multi_az                = false
}

resource "aws_db_instance" "replica" {
  identifier             = "my-db-replica"
  replicate_source_db    = aws_db_instance.my_db_instance.identifier

  instance_class         = "db.t3.micro"
  publicly_accessible    = false
  skip_final_snapshot    = true

  depends_on = [
    aws_db_instance.my_db_instance
  ]
}
