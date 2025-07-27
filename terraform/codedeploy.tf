# CodeDeploy Application
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
  
  # FIXED: Use a proper deployment configuration
  deployment_config_name = "CodeDeployDefault.AllInstancesAtOnce"

  # Auto Rollback configuration
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE", "DEPLOYMENT_STOP_ON_ALARM"]
  }

  # FIXED: Add deployment style configuration
  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  # Target instances using Auto Scaling Group
  autoscaling_groups = [aws_autoscaling_group.app_asg.name]

  # FIXED: Add EC2 tag filters as backup targeting method
  ec2_tag_filter {
    key   = "Environment"
    type  = "KEY_AND_VALUE"
    value = var.environment
  }

  ec2_tag_filter {
    key   = "Project"
    type  = "KEY_AND_VALUE"
    value = var.project_name
  }

  # Load balancer info (conditional - only if using ALB)
  dynamic "load_balancer_info" {
    for_each = var.use_load_balancer ? [1] : []
    content {
      target_group_info {
        name = aws_lb_target_group.app_tg[0].name
      }
    }
  }

  # ADDED: Blue/Green deployment configuration (commented out for now)
  # blue_green_deployment_config {
  #   terminate_blue_instances_on_deployment_success {
  #     action                         = "TERMINATE"
  #     termination_wait_time_in_minutes = 5
  #   }
  #   
  #   deployment_ready_option {
  #     action_on_timeout = "CONTINUE_DEPLOYMENT"
  #   }
  #   
  #   green_fleet_provisioning_option {
  #     action = "COPY_AUTO_SCALING_GROUP"
  #   }
  # }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# ADDED: CodeDeploy Deployment Configuration (optional custom config)
resource "aws_codedeploy_deployment_config" "custom_config" {
  deployment_config_name = "${var.project_name}-custom-config"
  compute_platform       = "Server"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 1
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}