resource "aws_codebuild_project" "react_build" {
  name         = "ReactAppBuild"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:6.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    # Environment variables for Docker image build and push
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_repo_name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml" # Correct placement
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/ReactAppBuild"
      stream_name = "build-log"
    }
  }
}
