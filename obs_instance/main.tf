#create prometheus ec2 
resource "aws_instance" "prometheus" {
  count = 1
  ami     = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet
  vpc_security_group_ids = [var.prometheus_sg]
  user_data = file("${path.module}/prometheus.sh")
  key_name = var.key_pair_name
  iam_instance_profile = var.iam_instance_profile_name

  tags = {
    Name = "prometheus"
  }

}

#create grafana ec2 
resource "aws_instance" "grafana" {
  count = 1
  ami     = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet
  vpc_security_group_ids = [var.grafana_sg]
  user_data = file("${path.module}/grafana.sh")
  key_name = var.key_pair_name

  tags = {
    Name = "grafana"
  }

}