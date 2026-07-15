variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
  default     = "ami-01edba92f9036f76e"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Simple tag value used in examples"
  type        = string
  default     = "my-instance"
}
