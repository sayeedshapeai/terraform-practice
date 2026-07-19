variable "ami_id" {
  description = "The ami id for ec2 instance"
  type = string
  default = ""
}
variable "instance_type" {
  description = "The instance type for ec2 instance"
  type = string
  default = ""
}
variable "tags" {
  description = "the tags for ec2 instance"
  type = string
  default = ""
}

