resource "aws_appautoscaling_policy" "cpu_high" {
  count              = var.scale_type == "cpu" ? 1 : 0
  name               = format("%s-%s-cpu-scaling-out", var.cluster_name, var.service_name)
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.main.resource_id
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  service_namespace  = aws_appautoscaling_target.main.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeinCapacity"
    cooldown                = var.scalin_out_cooldown
    metric_aggregation_type = var.scalin_out_statistic

    step_adjustment {
      scaling_adjustment          = var.scalin_out_adjustment
      metric_interval_lower_bound = 0
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "high" {
  count = var.scale_type == "cpu" ? 1 : 0

  alarm_name          = format("%s-%s-cpu-high", var.cluster_name, var.service_name)
  comparison_operator = var.scalin_out_comparison_operator

  evaluation_periods = var.scalin_out_evaluation_periods

  metric_name       = "CPUUtilization"
  namespace         = "AWS/ECS"
  period            = var.scalin_out_period
  statistic         = var.scalin_out_statistic
  threshold         = var.scalin_out_threshold
  alarm_description = "This metric monitors ECS service CPU utilization"
  alarm_actions     = [aws_appautoscaling_policy.cpu_high[count.index].arn]

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
}

resource "aws_appautoscaling_policy" "cpu_low" {
  count              = var.scale_type == "cpu" ? 1 : 0
  name               = format("%s-%s-cpu-scaling-in", var.cluster_name, var.service_name)
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.main.resource_id
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  service_namespace  = aws_appautoscaling_target.main.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeinCapacity"
    cooldown                = var.scalin_in_cooldown
    metric_aggregation_type = var.scalin_in_statistic

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.scalin_in_adjustment
    }

    step_adjustment {
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = var.scalin_in_threshold
      scaling_adjustment          = var.scalin_in_adjustment
    }

    step_adjustment {
      metric_interval_lower_bound = var.scalin_in_threshold
      scaling_adjustment          = 0
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "low" {
  count = var.scale_type == "cpu" ? 1 : 0

  alarm_name          = format("%s-%s-cpu-low", var.cluster_name, var.service_name)
  comparison_operator = var.scalin_in_comparison_operator

  evaluation_periods = var.scalin_in_evaluation_periods

  metric_name       = "CPUUtilization"
  namespace         = "AWS/ECS"
  period            = var.scalin_in_period
  statistic         = var.scalin_in_statistic
  threshold         = var.scalin_in_threshold
  alarm_description = "This metric monitors ECS service CPU utilization"
  alarm_actions     = [aws_appautoscaling_policy.cpu_high[count.index].arn]

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
}
