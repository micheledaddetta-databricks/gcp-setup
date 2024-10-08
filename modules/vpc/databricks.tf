resource "databricks_mws_vpc_endpoint" "backend_rest_vpce" {
depends_on =[google_compute_forwarding_rule.backend_psc_ep]
 provider     = databricks.accounts

 account_id          = var.databricks_account_id
 vpc_endpoint_name   = "${var.shared_name}-vpce-backend-rest"
 gcp_vpc_endpoint_info {
   project_id        = var.google_project
   psc_endpoint_name = google_compute_forwarding_rule.frontend_psc_ep.name
   endpoint_region   = google_compute_subnetwork.network-with-private-secondary-ip-ranges.region
 }
}

resource "databricks_mws_vpc_endpoint" "relay_vpce" {
  depends_on = [ google_compute_forwarding_rule.frontend_psc_ep ]
 provider     = databricks.accounts

 account_id          = var.databricks_account_id
 vpc_endpoint_name   = "${var.shared_name}-vpce-relay"
 gcp_vpc_endpoint_info {
   project_id        = var.google_project
   psc_endpoint_name = google_compute_address.backend_pe_ip_address.name
   endpoint_region   = google_compute_subnetwork.network-with-private-secondary-ip-ranges.region
 }
}


resource "databricks_mws_networks" "this" {
  provider     = databricks.accounts
  account_id   = var.databricks_account_id
  network_name = "${var.shared_name}-network"
  gcp_network_info {
    network_project_id    = var.google_project
    vpc_id                = google_compute_network.dbx_private_vpc.name
    subnet_id             = google_compute_subnetwork.network-with-private-secondary-ip-ranges.name
    subnet_region         = google_compute_subnetwork.network-with-private-secondary-ip-ranges.region
    pod_ip_range_name     = "pods"
    service_ip_range_name = "svc"
  }
  vpc_endpoints {

   dataplane_relay = [databricks_mws_vpc_endpoint.relay_vpce.vpc_endpoint_id]
   rest_api        = [databricks_mws_vpc_endpoint.backend_rest_vpce.vpc_endpoint_id]
  }

}