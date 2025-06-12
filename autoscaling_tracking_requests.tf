resource "aws_appautoscaling_policy" "target_tracking_reqiests" {
  count = var.scale_type == "cpu_tracking" ? 1 : 0

  name = format("%s-%s-requests-tracking", var.cluster_name, var.service_name)

  policy_type = "TargetTrackingScaling"

  resource_id        = aws_appautoscaling_target.main.resource_id
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  service_namespace  = aws_appautoscaling_target.main.service_namespace

  target_tracking_scaling_policy_configuration {

    target_value       = var.scaling_tracking_cpu
    scale_in_cooldown  = var.scalin_in_cooldown
    scale_out_cooldown = var.scalin_out_cooldown

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestPerTarget"
      resource_label         = "${data.aws_alb.main.arn_suffix}/${aws_alb_target_group.main.arn_suffix}"


    }
  }
}
