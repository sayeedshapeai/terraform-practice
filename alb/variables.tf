variable "region" {}

variable "vpc_id" {}

variable "public_subnet1" {}

variable "public_subnet2" {}

variable "ami" {
  default = ""
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {}

variable "ssh_cidr" {
  description = "CIDR allowed for SSH (e.g. 1.2.3.4/32). Leave empty to disable SSH ingress."
  type        = string
  default     = ""
}
