variable "db_identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "storage" {
  type = number
}

variable "username" {
  type = string
}

variable "password" {
  type = string
  sensitive = true
}

variable "db_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_group_name" {
  type = string
}
