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
