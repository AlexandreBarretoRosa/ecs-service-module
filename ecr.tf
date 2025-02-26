resource "aws_ecr_repository" "main" {

  name         = format("%s-ecr", var.cluster_name, var.service_name)
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

}