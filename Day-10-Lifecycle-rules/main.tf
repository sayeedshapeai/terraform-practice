resource "aws_instance" "name" {
  ami           = "ami-0b826bb6d96d2afe4"
  instance_type = "t3.micro"

  tags = {
    Name = "server-1"
  }

  lifecycle {
    create_before_destroy = true   #first create new resource then destroy the old one
    ignore_changes         = [tags]
  }


  lifecycle {
    ignore_changes = [tags]     
  }



  lifecycle {
    create_before_destroy = true
    ignore_changes         = [tags] 
    prevent_destroy        = true
  }
}
 