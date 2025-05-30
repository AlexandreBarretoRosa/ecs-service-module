resource "aws_ecs_service" "main" {
  name          = var.service_name
  cluster       = var.cluster_name
  desired_count = var.service_task_count
  launch_type   = var.service_launch_type

  task_definition = aws_ecs_task_definition.main.arn

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  ### Estrategia de distribuição das tasks nos hosts, só utiliza quando
  ### o launch_type for EC2

  dynamic "ordered_placement_strategy" {
    for_each = var.service_launch_type == "EC2" ? [1] : []
    content {
      type  = "spread"
      field = "attribute:ecs.availability-zone"
    }

  }

  network_configuration {
    security_groups = [aws_security_group.main.id]

    subnets = var.private_subnets

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = var.service_name
    container_port   = var.service_port
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  #platform_version = "LATEST"

  depends_on = []
}