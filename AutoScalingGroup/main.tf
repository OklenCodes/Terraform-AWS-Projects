provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      hashicorp-learn = "aws-asg"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]  # This might not be necessary anymore

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]  # Specify Amazon Linux 2 pattern
  }
}

resource "aws_launch_configuration" "terratutorial" {
  name_prefix = "learn-terraform-aws-asg-"
  image_id = data.aws_ami.amazon_linux.id  # Now references the declared resource
  instance_type = "t2.micro"
  
}

resource "aws_autoscaling_group" "terratutorial" {
  name                 = "terratutorial"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.terratutorial.name
  vpc_zone_identifier  = module.vpc.public_subnets

  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "HashiCorp Learn ASG - terratutorial"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "terratutorial-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.terratutorial.name
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "terratutorial-scale-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"                          # 2 minutes
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terratutorial.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.scale_down.arn]
}

resource "aws_lb" "terratutorial" {
  name               = "learn-asg-terratutorial-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terratutorial_lb.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_listener" "terratutorial" {
  load_balancer_arn = aws_lb.terratutorial.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terratutorial.arn
  }
}

resource "aws_lb_target_group" "terratutorial" {
  name     = "learn-asg-terratutorial"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}


resource "aws_autoscaling_attachment" "terratutorial" {
  autoscaling_group_name = aws_autoscaling_group.terratutorial.id
  alb_target_group_arn   = aws_lb_target_group.terratutorial.arn
}

resource "aws_security_group" "terratutorial_instance" {
  name = "learn-asg-terratutorial-instance"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.terratutorial_lb.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "terratutorial_lb" {
  name = "learn-asg-terratutorial-lb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}
