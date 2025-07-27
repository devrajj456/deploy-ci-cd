"# CodeDeploy Application
resource "aws_codedeploy_app" "app" {
  compute_platform = "Server"
  name             = "${var.project_name}-app"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# CodeDeploy Deployment Group
resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = "${var.project_name}-deployment-group"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  # Auto Rollback configuration
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  # Target instances using Auto Scaling Group
  autoscaling_groups = [aws_autoscaling_group.app_asg.name]

  # Load balancer info
  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.app_tg.name
    }
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}