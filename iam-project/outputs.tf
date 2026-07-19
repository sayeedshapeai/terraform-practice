output "iam_user" {

 value = aws_iam_user.user.name

}

output "iam_group" {

 value = aws_iam_group.developers.name

}

output "iam_role" {

 value = aws_iam_role.ec2_role.name

}