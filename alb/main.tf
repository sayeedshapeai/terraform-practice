data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  vpc_id = var.vpc_id == "YOUR_VPC_ID" || var.vpc_id == "" ? data.aws_vpc.default.id : var.vpc_id
  public_subnet1 = var.public_subnet1 == "YOUR_PUBLIC_SUBNET1" || var.public_subnet1 == "" ? data.aws_subnets.default.ids[0] : var.public_subnet1
  public_subnet2 = var.public_subnet2 == "YOUR_PUBLIC_SUBNET2" || var.public_subnet2 == "" ? data.aws_subnets.default.ids[1] : var.public_subnet2
}

# Lookup a recent Amazon Linux 2 AMI if `var.ami` is not set or invalid
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

locals {
  ami_id = var.ami != "" ? var.ami : data.aws_ami.amazon_linux.id
}

resource "aws_security_group" "alb_sg" {

  name = "alb-security-group"

  description = "Security Group for Application Load Balancer"

  vpc_id = local.vpc_id

  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = {

    Name = "ALB-Security-Group"

  }

}
resource "aws_security_group" "ec2_sg" {

  name = "ec2-security-group"

  description = "Security Group for EC2"

  vpc_id = local.vpc_id

  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]

  }

  dynamic "ingress" {
    for_each = var.ssh_cidr != "" ? [var.ssh_cidr] : []
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

}

resource "aws_instance" "web1" {

  ami = local.ami_id

  instance_type = var.instance_type

  subnet_id = local.public_subnet1

  key_name = var.key_name != "" ? var.key_name : null

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<EOF
#!/bin/bash
yum install httpd -y
systemctl enable httpd
systemctl start httpd
echo "<h1>Server 1</h1>" > /var/www/html/index.html
EOF

}
resource "aws_instance" "web2" {

  ami = local.ami_id

  instance_type = var.instance_type

  subnet_id = local.public_subnet2

  key_name = var.key_name != "" ? var.key_name : null

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<EOF
#!/bin/bash
yum install httpd -y
systemctl enable httpd
systemctl start httpd
echo "<h1>Server 2</h1>" > /var/www/html/index.html
EOF

}
resource "aws_lb" "alb" {

  name = "my-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [aws_security_group.alb_sg.id]

  subnets = [
    local.public_subnet1,
    local.public_subnet2
  ]

}
resource "aws_lb_target_group" "tg" {

  name = "alb-target-group"

  port = 80

  protocol = "HTTP"

  vpc_id = local.vpc_id

}
resource "aws_lb_target_group_attachment" "web1" {

  target_group_arn = aws_lb_target_group.tg.arn

  target_id = aws_instance.web1.id

  port = 80

}

resource "aws_lb_target_group_attachment" "web2" {

  target_group_arn = aws_lb_target_group.tg.arn

  target_id = aws_instance.web2.id

  port = 80

}
resource "aws_lb_listener" "listener" {

  load_balancer_arn = aws_lb.alb.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.tg.arn

  }

}