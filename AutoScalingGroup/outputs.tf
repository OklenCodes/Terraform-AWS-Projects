output "lb_endpoint" {
  value = "http://${aws_lb.terratutorial.dns_name}"
}

output "application_endpoint" {
  value = "http://${aws_lb.terratutorial.dns_name}/index.php"
}

output "asg_name" {
  value = aws_autoscaling_group.terratutorial.name
}
