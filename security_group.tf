resource "aws_security_group" "demo" {
  name   = format("%s-ec2", var.project_name)
  vpc_id = data.aws_ssm_parameter.vpc.value

  tags = {
    Name        = format("%s-ec2", var.project_name)
    Environment = var.environment
    Terraform   = "True"
  }
}

resource "aws_vpc_security_group_egress_rule" "demo_https" {
  security_group_id = aws_security_group.demo.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
