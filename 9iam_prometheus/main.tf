resource "aws_iam_role" "prometheus_role" {
  name = "prometheus-ec2-role"

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
#=========================================================================
#setting up policy for the role
resource "aws_iam_policy" "prometheus_ec2_discovery" {
  name = "prometheus-ec2-discovery"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:DescribeAvailabilityZones"
        ]
        Resource = "*"
      }
    ]
  })
}
#=========================================================================
#attach policy to the role

resource "aws_iam_role_policy_attachment" "prometheus_attach" {
  role       = aws_iam_role.prometheus_role.name
  policy_arn = aws_iam_policy.prometheus_ec2_discovery.arn
}

#=========================================================================
#output the role ARN for use in EC2 instance profile
resource "aws_iam_instance_profile" "prometheus_profile" {
  name = "prometheus-instance-profile"
  role = aws_iam_role.prometheus_role.name
}