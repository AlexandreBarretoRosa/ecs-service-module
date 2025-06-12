variable "region" {
  type        = string
  description = "AWS region"
}

variable "service_name" {

  type        = string
  description = "Name of the ECS service"
}

variable "container_image" {
  type        = string
  description = "Imagem com tag para deploy da aplicação"
}

variable "cluster_name" {

  type        = string
  description = "Name of the ECS cluster"
}

variable "vpc_id" {

  type        = string
  description = "VPC ID where the service will be deployed"
}

variable "private_subnets" {

  type        = list(string)
  description = "List of private subnet IDs"
}

variable "service_port" {

  type        = number
  description = "Port number for the service"
}

variable "service_cpu" {

  type        = number
  description = "CPU units for the service"
}

variable "service_memory" {

  type        = number
  description = "Memory allocation for the service in MiB"
}

variable "service_listener" {

  type        = string
  description = "ARN of the ALB listener"
}

variable "alb_arn" {
  type        = string
  description = "ARN do Application Load Balancer"
}

variable "listener_arn" {
  type        = string
  description = "ARN do Listener do ALB"
}

variable "service_task_execution_role" {

  type        = string
  description = "ARN of the task execution role"
}

variable "environment_variables" {
  type        = list(any)
  description = "List of environment variables for the container"
}

variable "capabilities" {
  type        = list(any)
  description = "List of IAM capabilities required"
}

variable "service_healthcheck" {
  type        = map(any)
  description = "Health check configuration for the service"
}

variable "service_launch_type" {
  type        = string
  description = "Launch type for the ECS service (FARGATE or EC2)"
  default     = "FARGATE"
}

variable "service_task_count" {
  type        = number
  description = "Number of tasks to run"
  default     = 1
}

variable "service_hosts" {
  type        = list(string)
  description = "List of host names for the service"
  default     = []
}

variable "scale_type" {
  type        = string
  description = "Type of scaling (cpu or memory)"
  default     = "cpu"
}

variable "task_minimum" {
  type        = number
  description = "Minimum number of tasks"
  default     = 1
}

variable "task_maximum" {
  type        = number
  description = "Maximum number of tasks"
  default     = 5
}

### Auto scaling de CPU

variable "scalin_out_threshold" {
  type        = number
  description = "CPU threshold percentage for scaling out"
  default     = 80
}

variable "scalin_out_adjustment" {
  type        = number
  description = "Number of tasks to add when scaling out"
  default     = 1
}

variable "scalin_out_comparison_operator" {
  type        = string
  description = "Comparison operator for scaling out"
  default     = "GreaterThanOrEqualToThreshold"
}

variable "scalin_out_statistic" {
  type        = string
  description = "Statistic to use for scaling (Average, Maximum, etc)"
  default     = "Average"
}

variable "scalin_out_period" {
  type        = number
  description = "Period in seconds over which to evaluate the alarm"
  default     = 60
}

variable "scalin_out_evaluation_periods" {
  type        = number
  description = "Number of periods to evaluate the alarm"
  default     = 2
}

variable "scalin_out_cooldown" {
  type        = number
  description = "Cooldown period in seconds"
  default     = 60
}

variable "scalin_in_threshold" {
  type        = number
  description = "CPU threshold percentage for scaling out"
  default     = 80
}

variable "scalin_in_adjustment" {
  type        = number
  description = "Number of tasks to add when scaling out"
  default     = 1
}

variable "scalin_in_comparison_operator" {
  type        = string
  description = "Comparison operator for scaling out"
  default     = "LessThanOrEqualToThreshold"
}

variable "scalin_in_statistic" {
  type        = string
  description = "Statistic to use for scaling (Average, Maximum, etc)"
  default     = "Average"
}

variable "scalin_in_period" {
  type        = number
  description = "Period in seconds over which to evaluate the alarm"
  default     = 120
}

variable "scalin_in_evaluation_periods" {
  type        = number
  description = "Number of periods to evaluate the alarm"
  default     = 3
}

variable "scalin_in_cooldown" {
  type        = number
  description = "Cooldown period in seconds"
  default     = 120
}

### Tracking CPU
variable "scaling_tracking_cpu" {
  default = 80
}

### Tracking requests

variable "scalin_tracking_requests" {
  default = 0
}

### EFS
variable "efs_volumes" {
  type = list(object({
    volume_name : string
    file_system_id : string
    file_system_root : string
    mount_point : string
    read_inly : bool
  }))

}