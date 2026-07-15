output "public_ip" {
  value       = aws_instance.dev_instance.public_ip
  description = "public ip of the instance"
}

output "private_ip" {
  value       = aws_instance.dev_instance.private_ip
  description = "private ip of the instance"
}

output "instance_id" {
  value       = aws_instance.dev_instance.id
  description = "id of the instance"
}

output "az" {
  value       = aws_instance.dev_instance.availability_zone
  description = "availability zone of the instance"
}

output "vpc_id" {
  value       = aws_vpc.dev_vpc.id
  description = "id of the vpc"
}
