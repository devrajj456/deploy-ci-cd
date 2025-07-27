resource "aws_codebuild_project" "build_project" {
  name          = "ReactAppBuild"
  description   = "CodeBuild project for building and pushing Docker image"
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = 30 # Minutes

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:6.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true # Required for Docker builds

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

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml" # Ensure this file is in root of your repo
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/ReactAppBuild"
      stream_name = "build-log"
    }
  }
}
