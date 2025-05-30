resource "aws_ssm_parameter" "alb_arn" {
  name      = "/container-vpc/alb/alb_arn"
  type      = "String"
  value     = var.alb_arn
  overwrite = true
}

resource "aws_ssm_parameter" "listener" {
  name      = "/container-vpc/alb/listener"
  type      = "String"
  value     = var.listener_arn
  overwrite = true
}


