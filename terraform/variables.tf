variable "aws_region" {
  description = "AWS region"  
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "devops-pipeline"
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch"
  type        = string
  default     = "main"
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "image_repo_name" {
  description = "ECR repository name for Docker images"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
}