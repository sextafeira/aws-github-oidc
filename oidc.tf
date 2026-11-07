resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

resource "aws_iam_role" "github" {
  for_each = toset(["s3", "ec2"])
  name     = format("%s-%s", var.project_name, each.key)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          "token.actions.githubusercontent.com:sub" = format(
            "repo:%s@%s/%s@%s:ref:refs/heads/%s",
            var.github_owner, var.github_owner_id,
            var.github_repository, var.github_repository_id,
            var.github_branch
          )
        }
      }
    }]
  })
}
