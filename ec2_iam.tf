resource "aws_iam_role" "ec2" {
  name = format("%s-ec2-ssm", var.project_name)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = format("%s-ec2-ssm", var.project_name)
    Environment = var.environment
    Terraform   = "True"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2.name
  policy_arn = format("arn:%s:iam::aws:policy/AmazonSSMManagedInstanceCore", data.aws_partition.current.partition)
}

resource "aws_iam_instance_profile" "ec2" {
  name = format("%s-ec2-ssm", var.project_name)
  role = aws_iam_role.ec2.name

  tags = {
    Name        = format("%s-ec2-ssm", var.project_name)
    Environment = var.environment
    Terraform   = "True"
  }
}
