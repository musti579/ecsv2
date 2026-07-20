output "listener_arn" {
  value = aws_lb_listener.api_listener.arn
}

output "api_blue_tg_name" {
  value = aws_lb_target_group.api_blue.name
}

output "api_green_tg_name" {
  value = aws_lb_target_group.api_green.name
}

output "dashboard_blue_tg_name" {
  value = aws_lb_target_group.dashboard_blue.name
}

output "dashboard_green_tg_name" {
  value = aws_lb_target_group.dashboard_green.name
}

output "ecs_sg_id" {
  value = aws_security_group.ecs2_sg.id
}