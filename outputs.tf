output "github_variables" {
  description = "Configure em Settings > Secrets and variables > Actions > Variables."
  value = {
    AWS_REGION                = var.region
    AWS_S3_ROLE_ARN           = aws_iam_role.github["s3"].arn
    AWS_EC2_ROLE_ARN          = aws_iam_role.github["ec2"].arn
    S3_BUCKET_NAME            = aws_s3_bucket.demo.id
    SUBNET_ID                 = nonsensitive(data.aws_ssm_parameter.private_subnet.value)
    SECURITY_GROUP_ID         = aws_security_group.demo.id
    IAM_INSTANCE_PROFILE_NAME = aws_iam_instance_profile.ec2.name
  }
}
