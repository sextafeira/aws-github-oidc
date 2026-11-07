resource "aws_iam_role_policy" "ec2" {
  name = format("%s-create-ec2", var.project_name)
  role = aws_iam_role.github["ec2"].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:RunInstances", "ec2:CreateTags"]
        Resource = "*"
        Condition = {
          StringEquals = { "aws:RequestedRegion" = var.region }
        }
      },
      {
        Effect   = "Allow"
        Action   = ["ssm:GetParameters"]
        Resource = format("arn:%s:ssm:%s::parameter/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64", data.aws_partition.current.partition, var.region)
      },
      {
        Effect   = "Allow"
        Action   = ["iam:PassRole"]
        Resource = aws_iam_role.ec2.arn
        Condition = {
          StringEquals = { "iam:PassedToService" = "ec2.amazonaws.com" }
        }
      }
    ]
  })
}
