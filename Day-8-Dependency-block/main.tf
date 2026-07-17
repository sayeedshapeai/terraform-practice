provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
  
}
resource"aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-1234567890"
}

#dependency block 