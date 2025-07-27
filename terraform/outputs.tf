output "codepipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.pipeline.name
}

output "codepipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.pipeline.arn
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.build_project.name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for artifacts"
  value       = aws_s3_bucket.codepipeline_artifacts.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket for artifacts"
  value       = aws_s3_bucket.codepipeline_artifacts.arn
}

output "codedeploy_app_name" {
  description = "Name of the CodeDeploy application"
  value       = aws_codedeploy_app.app.name
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.app_lb.dns_name
}

output "load_balancer_url" {
  description = "URL of the application"
  value       = "http://${aws_lb.app_lb.dns_name}"
}