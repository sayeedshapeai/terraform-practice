resource "aws_iam_user" "user" {

  name = var.user_name

}
resource "aws_iam_group" "developers" {

  name = var.group_name

}
resource "aws_iam_group_membership" "membership" {

  name = "developer-membership"

  users = [

    aws_iam_user.user.name

  ]

  group = aws_iam_group.developers.name

}
resource "aws_iam_policy" "ec2_readonly" {

  name = "EC2ReadOnly"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "ec2:Describe*"

        ]

        Resource = "*"

      }

    ]

  })

}
resource "aws_iam_group_policy_attachment" "attach" {

  group = aws_iam_group.developers.name

  policy_arn = aws_iam_policy.ec2_readonly.arn

}
resource "aws_iam_role" "ec2_role" {

  name = "EC2Role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}
resource "aws_iam_role_policy_attachment" "s3" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

}