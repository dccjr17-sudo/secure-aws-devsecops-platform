locals {
  # Phase 1 is intentionally a two-AZ foundation. Expand this deliberately in
  # a future architecture decision rather than adding subnets by accident.
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "network" {
  source = "../../modules/network"

  project_name            = var.project_name
  environment             = var.environment
  vpc_cidr                = var.vpc_cidr
  availability_zones      = local.availability_zones
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  flow_log_retention_days = var.flow_log_retention_days

  tags = {
    DataClassification = "Lab"
    Owner              = "Portfolio"
  }
}

module "container_registry" {
  source = "../../modules/registry"

  project_name         = var.project_name
  environment          = var.environment
  retained_image_count = 10

  tags = {
    DataClassification = "Lab"
    Owner              = "Portfolio"
  }
}

module "github_actions_oidc" {
  source = "../../modules/github_actions_oidc"

  project_name = var.project_name
  environment  = var.environment

  # GitHub repositories created after July 15, 2026 use an immutable OIDC
  # subject format. This exact subject permits only the main branch of this
  # repository to request the publishing role.
  github_oidc_subject = "repo:dccjr17-sudo@233174618/secure-aws-devsecops-platform@1359570339:ref:refs/heads/main"
  ecr_repository_arn  = module.container_registry.repository_arn

  tags = {
    DataClassification = "Lab"
    Owner              = "Portfolio"
  }
}

module "security_observability" {
  source = "../../modules/security_observability"

  project_name                     = var.project_name
  environment                      = var.environment
  audit_log_retention_days         = var.audit_log_retention_days
  secret_recovery_window_in_days   = var.secret_recovery_window_in_days
  kms_key_deletion_window_in_days  = var.kms_key_deletion_window_in_days
  enable_threat_detection_services = var.enable_threat_detection_services

  tags = {
    DataClassification = "Lab"
    Owner              = "Portfolio"
  }
}
