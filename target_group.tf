resource "aws_alb_target_group" "main" {
  name        = substr(format("%s%s", var.cluster_name, var.service_name), 0, 32)
  port        = var.service_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = lookup(var.service_healthcheck, "healthy_threshold", 3)
    unhealthy_threshold = lookup(var.service_healthcheck, "unhealthy_threshold", 10)
    timeout             = lookup(var.service_healthcheck, "timeout", 10)
    interval            = lookup(var.service_healthcheck, "interval", 10)
    matcher             = lookup(var.service_healthcheck, "matcher", 200)
    path                = lookup(var.service_healthcheck, "path", "/")
    port                = lookup(var.service_healthcheck, "port", var.service_port)

  }

  lifecycle {
    create_before_destroy = false
  }
}
