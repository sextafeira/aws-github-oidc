data "aws_ssm_parameter" "vpc" {
  name = "/vpc_id"
}

data "aws_ssm_parameter" "private_subnet" {
  name = "/private_subnet_1a_id"
}
