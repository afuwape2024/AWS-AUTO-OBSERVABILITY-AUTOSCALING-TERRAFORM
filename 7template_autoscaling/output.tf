output "web_launch_template" {
  value = aws_launch_template.web_launch_template.id
}

output "web_asg" {
  value = aws_autoscaling_group.auto_scaling_group.id
}
output "auto_scaling_group" {
  value = aws_autoscaling_group.auto_scaling_group.id
}

output "scale_out" {
  value = aws_autoscaling_policy.scale_out.id
}
output "scale_in" {
  value = aws_autoscaling_policy.scale_in.id
}