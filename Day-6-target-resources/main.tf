# creation of vpc with custom network configuration
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev"
  }
}

# creation of subnet with custom network configuration
resource "aws_subnet" "dev_subnet" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "dev-subnet"
  }
}

#terraform target command is used to apply the changes to specific resources in the configuration. It allows you to selectively apply changes to certain resources without affecting the entire infrastructure. This can be useful when you want to make changes to a specific resource or set of resources without impacting other parts of your infrastructure.

ex: terraform plan --target=aws_vpc.dev_vpc
    terraform apply --target=aws_vpc.dev_vpc