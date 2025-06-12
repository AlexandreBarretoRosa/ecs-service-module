# ecs-service-module
repositório do modulo do service do cluster ecs

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.99.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener_rule.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |
| [aws_alb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_appautoscaling_policy.cpu_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.cpu_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.target_tracking_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.target_tracking_reqiests](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_ecs_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.service_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.service_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ssm_parameter.alb_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_alb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/alb) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_arn"></a> [alb\_arn](#input\_alb\_arn) | ARN do Application Load Balancer | `string` | n/a | yes |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | List of IAM capabilities required | `list(any)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the ECS cluster | `string` | n/a | yes |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Imagem com tag para deploy da aplicação | `string` | n/a | yes |
| <a name="input_efs_volumes"></a> [efs\_volumes](#input\_efs\_volumes) | Volume efs existente para serem montados nas tasks do ECS | <pre>list(object({<br/>    volume_name : string<br/>    file_system_id : string<br/>    file_system_root : string<br/>    mount_point : string<br/>    read_inly : bool<br/>  }))</pre> | `[]` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | List of environment variables for the container | `list(map(string))` | `[]` | no |
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | ARN do Listener do ALB | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_scale_type"></a> [scale\_type](#input\_scale\_type) | Type of scaling (cpu or memory) | `string` | `"cpu"` | no |
| <a name="input_scalin_in_adjustment"></a> [scalin\_in\_adjustment](#input\_scalin\_in\_adjustment) | Number of tasks to add when scaling out | `number` | `1` | no |
| <a name="input_scalin_in_comparison_operator"></a> [scalin\_in\_comparison\_operator](#input\_scalin\_in\_comparison\_operator) | Comparison operator for scaling out | `string` | `"LessThanOrEqualToThreshold"` | no |
| <a name="input_scalin_in_cooldown"></a> [scalin\_in\_cooldown](#input\_scalin\_in\_cooldown) | Cooldown period in seconds | `number` | `120` | no |
| <a name="input_scalin_in_evaluation_periods"></a> [scalin\_in\_evaluation\_periods](#input\_scalin\_in\_evaluation\_periods) | Number of periods to evaluate the alarm | `number` | `3` | no |
| <a name="input_scalin_in_period"></a> [scalin\_in\_period](#input\_scalin\_in\_period) | Period in seconds over which to evaluate the alarm | `number` | `120` | no |
| <a name="input_scalin_in_statistic"></a> [scalin\_in\_statistic](#input\_scalin\_in\_statistic) | Statistic to use for scaling (Average, Maximum, etc) | `string` | `"Average"` | no |
| <a name="input_scalin_in_threshold"></a> [scalin\_in\_threshold](#input\_scalin\_in\_threshold) | CPU threshold percentage for scaling out | `number` | `80` | no |
| <a name="input_scalin_out_adjustment"></a> [scalin\_out\_adjustment](#input\_scalin\_out\_adjustment) | Number of tasks to add when scaling out | `number` | `1` | no |
| <a name="input_scalin_out_comparison_operator"></a> [scalin\_out\_comparison\_operator](#input\_scalin\_out\_comparison\_operator) | Comparison operator for scaling out | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| <a name="input_scalin_out_cooldown"></a> [scalin\_out\_cooldown](#input\_scalin\_out\_cooldown) | Cooldown period in seconds | `number` | `60` | no |
| <a name="input_scalin_out_evaluation_periods"></a> [scalin\_out\_evaluation\_periods](#input\_scalin\_out\_evaluation\_periods) | Number of periods to evaluate the alarm | `number` | `2` | no |
| <a name="input_scalin_out_period"></a> [scalin\_out\_period](#input\_scalin\_out\_period) | Period in seconds over which to evaluate the alarm | `number` | `60` | no |
| <a name="input_scalin_out_statistic"></a> [scalin\_out\_statistic](#input\_scalin\_out\_statistic) | Statistic to use for scaling (Average, Maximum, etc) | `string` | `"Average"` | no |
| <a name="input_scalin_out_threshold"></a> [scalin\_out\_threshold](#input\_scalin\_out\_threshold) | CPU threshold percentage for scaling out | `number` | `80` | no |
| <a name="input_scalin_tracking_requests"></a> [scalin\_tracking\_requests](#input\_scalin\_tracking\_requests) | n/a | `number` | `0` | no |
| <a name="input_scaling_tracking_cpu"></a> [scaling\_tracking\_cpu](#input\_scaling\_tracking\_cpu) | ## Tracking CPU | `number` | `80` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | lista de secrets do parametr stor ou secrets manager | <pre>list(object({<br/>    name : string<br/>    value : string<br/>  }))</pre> | `[]` | no |
| <a name="input_service_cpu"></a> [service\_cpu](#input\_service\_cpu) | CPU units for the service | `number` | n/a | yes |
| <a name="input_service_healthcheck"></a> [service\_healthcheck](#input\_service\_healthcheck) | Health check configuration for the service | `map(any)` | n/a | yes |
| <a name="input_service_hosts"></a> [service\_hosts](#input\_service\_hosts) | List of host names for the service | `list(string)` | `[]` | no |
| <a name="input_service_launch_type"></a> [service\_launch\_type](#input\_service\_launch\_type) | Launch type for the ECS service (FARGATE or EC2) | `string` | `"FARGATE"` | no |
| <a name="input_service_listener"></a> [service\_listener](#input\_service\_listener) | ARN of the ALB listener | `string` | n/a | yes |
| <a name="input_service_memory"></a> [service\_memory](#input\_service\_memory) | Memory allocation for the service in MiB | `number` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the ECS service | `string` | n/a | yes |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Port number for the service | `number` | n/a | yes |
| <a name="input_service_task_count"></a> [service\_task\_count](#input\_service\_task\_count) | Number of tasks to run | `number` | `1` | no |
| <a name="input_service_task_execution_role"></a> [service\_task\_execution\_role](#input\_service\_task\_execution\_role) | ARN of the task execution role | `string` | n/a | yes |
| <a name="input_task_maximum"></a> [task\_maximum](#input\_task\_maximum) | Maximum number of tasks | `number` | `5` | no |
| <a name="input_task_minimum"></a> [task\_minimum](#input\_task\_minimum) | Minimum number of tasks | `number` | `1` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where the service will be deployed | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->