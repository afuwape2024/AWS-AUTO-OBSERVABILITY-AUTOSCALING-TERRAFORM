output "prometheus_instance_ids" {
  value = aws_instance.prometheus[*].id
}

output "grafana_instance_ids" {
  value = aws_instance.grafana[*].id
}

