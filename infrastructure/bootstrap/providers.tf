provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Phase       = "1-foundation"
    }
  }
}

data "aws_caller_identity" "current" {}
