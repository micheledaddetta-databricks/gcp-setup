module "network" {
  source = "./modules/vpc"


  databricks_account_id               = var.databricks_account_id
  google_pe_subnet_ip_cidr_range      = var.google_pe_subnet_ip_cidr_range
  google_pe_subnet_secondary_ip_range = var.google_pe_subnet_secondary_ip_range
  google_project                      = var.google_project
  nodes_ip_cidr_range                 = var.nodes_ip_cidr_range
  pod_ip_cidr_range                   = var.pod_ip_cidr_range
  region                              = var.region
  relay_service_attachment            = var.relay_service_attachment
  service_ip_cidr_range               = var.service_ip_cidr_range
  shared_name                         = var.shared_name
  workspace_service_attachment        = var.workspace_service_attachment
}