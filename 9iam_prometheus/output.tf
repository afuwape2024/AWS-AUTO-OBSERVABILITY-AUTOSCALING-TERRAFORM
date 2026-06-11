output "prometheus_role_name" {
  description = "IAM Role name for Prometheus"
  value       = aws_iam_role.prometheus_role.name
}

output "prometheus_role_arn" {
  description = "IAM Role ARN for Prometheus"
  value       = aws_iam_role.prometheus_role.arn
}

output "prometheus_policy_arn" {
  description = "EC2 Discovery Policy ARN"
  value       = aws_iam_policy.prometheus_ec2_discovery.arn
}

output "prometheus_instance_profile" {
  description = "Instance Profile Name"
  value       = aws_iam_instance_profile.prometheus_profile.name
}