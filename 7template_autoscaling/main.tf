#create launch template
resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "web-server-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair_name

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }
  

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.tier2_public_sg]
    subnet_id                   = var.public_subnet
  }

  user_data = filebase64("${path.module}/user_data2.sh")
  
  #for tagging instances launched by the autoscaling group
  #for prometheus discovery, we can add a tag like "Monitor=true" to identify instances to be monitored
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name    = "web-server"
      Monitor = "true"
    }
  }
}


resource "aws_autoscaling_group" "auto_scaling_group" {
  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.public_subnet, var.public_subnet2]
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1

  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out"
  scaling_adjustment       = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in"
  scaling_adjustment       = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
}
    
