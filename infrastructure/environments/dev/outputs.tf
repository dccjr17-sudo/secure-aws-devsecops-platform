output "vpc_id" {
  description = "Development VPC ID."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs reserved for controlled ingress."
  value       = module.network.public_subnet_ids
}

output "private_application_subnet_ids" {
  description = "Private subnet IDs reserved for application workloads."
  value       = module.network.private_subnet_ids
}

output "vpc_flow_log_group_name" {
  description = "CloudWatch log group receiving VPC Flow Logs."
  value       = module.network.flow_log_group_name
}

output "ecr_repository_name" {
  description = "Private ECR repository name."
  value       = module.container_registry.repository_name
}

output "ecr_repository_url" {
  description = "Private ECR repository URL for image push operations."
  value       = module.container_registry.repository_url
}

output "github_actions_ecr_publish_role_arn" {
  description = "Configure this value as the AWS_ROLE_TO_ASSUME GitHub Actions repository variable."
  value       = module.github_actions_oidc.role_arn
}
