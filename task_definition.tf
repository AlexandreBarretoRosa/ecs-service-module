resource "aws_ecs_task_definition" "main" {

  family = format("%s-%s", var.cluster_name, var.service_name)

  network_mode             = "awsvpc"
  requires_compatibilities = var.capabilities

  cpu    = var.service_cpu
  memory = var.service_memory

  execution_role_arn = aws_iam_role.service_execution_role.arn
  task_role_arn      = var.service_task_execution_role

  dynamic "volume" {
    for_each = var.efs_volumes
    content {
      name      = volume.value.volume_name
      host_path = volume.value.host_path
      efs_volume_configuration {
        file_system_id     = volume.value.file_system_id
        root_directory     = volume.value.file_system_root
        transit_encryption = "ENABLED"
      }
    }
  }

  # Fix: container_definitions should use jsonencode() not jsondecode()
  # Fix: Container definition should be a proper JSON object
  container_definitions = jsonencode([
    {
      name   = var.service_name
      image  = var.container_image
      cpu    = var.service_cpu
      memory = var.service_memory

      essential = true

      # Fix: portMappings instead of port_Mapping
      portMappings = [
        {
          containerPort = var.service_port
          hostPort      = var.service_port
          protocol      = "tcp"
        }
      ]

      # Fix: logConfiguration structure
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.main.id
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = var.service_name
        }
      }

      mountPoints = [
        for volume in var.efs_volumes : {
          containerPath = volume.mount_point
          sourceVolume  = volume.volume_name
          readOnly      = volume.read_only
        }
      ]

      # Fix: environment instead of environmemt
      environment = var.environment_variables

      secrets = var.secrets
    }
  ])

}
