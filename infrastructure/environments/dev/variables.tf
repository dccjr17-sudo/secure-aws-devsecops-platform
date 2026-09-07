variable "aws_region" {
  description = "AWS region for the development environment. Match the bootstrap region."
  type        = string
  default     = "us-west-2"
}

variable "aws_profile" {
  description = "Named AWS CLI profile or Identity Center profile. Leave null to use the SDK default credential chain."
  type        = string
  default     = null
  nullable    = true
}

variable "project_name" {
  description = "Lowercase project slug used in resource names."
  type        = string
  default     = "secure-aws-devsecops-platform"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,28}$", var.project_name))
    error_message = "project_name must be 3-28 lowercase letters, numbers, or hyphens."
  }
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^[a-z0-9-]{2,16}$", var.environment))
    error_message = "environment must be 2-16 lowercase letters, numbers, or hyphens."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the development VPC."
  type        = string
  default     = "10.42.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "One public-subnet CIDR per selected Availability Zone."
  type        = list(string)
  default     = ["10.42.0.0/24", "10.42.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "One private application-subnet CIDR per selected Availability Zone."
  type        = list(string)
  default     = ["10.42.10.0/24", "10.42.11.0/24"]
}

variable "flow_log_retention_days" {
  description = "CloudWatch retention period for VPC Flow Logs."
  type        = number
  default     = 30

  validation {
    condition     = var.flow_log_retention_days >= 7 && var.flow_log_retention_days <= 3653
    error_message = "flow_log_retention_days must be between 7 and 3653."
  }
}
