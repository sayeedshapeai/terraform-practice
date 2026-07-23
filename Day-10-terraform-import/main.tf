resource "aws_instance" "name" {
  ami           = "ami-0b826bb6d96d2afe4"
  instance_type = "t3.micro"
  tags = {
    Name = "server-1"
  }
}

resource "aws_s3_bucket" "name" {
  bucket = "sayeed-2026-devops"
}

resource "aws_s3_bucket_versioning" "example_versioning" {
  bucket = aws_s3_bucket.name.id

  versioning_configuration {
    status = "Enabled"
  }
}





#terraform import aws_instance.name i-0f3e1b2c3d4e5f6g7