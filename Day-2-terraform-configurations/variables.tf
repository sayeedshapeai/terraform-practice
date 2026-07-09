variable "cidr_block" {
    description = "The cidr block for the vpc"
    type = string
    default = "10.0.0.0/16"
}
variable "tag" {
    description = "The tag for the vpc"
    type = string
    default = "my-vpc"
}
variable "cidr_block_vpc-2" {
    description = "The cidr block for the vpc"
    type = string
    default = "10.0.0.0/24"
}
variable "cidr_block_subnet" {
    description = "The cidr block for the subnet"
    type = string
    default = "10.0.0.0/24"
}
variable "tag_subnet" {
    description = "The tag for the subnet tag"
    type = string
    default = "my-subnet"
}

