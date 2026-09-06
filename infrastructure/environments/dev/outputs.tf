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
