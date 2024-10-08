resource "google_compute_subnetwork" "backend_pe_subnetwork" {
  name          = "${var.shared_name}-psc-subnet"
  ip_cidr_range = var.google_pe_subnet_ip_cidr_range
  region        = var.region
  network       = google_compute_network.dbx_private_vpc.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = var.google_pe_subnet_secondary_ip_range
  }
    private_ip_google_access = true

            depends_on=[google_compute_network.dbx_private_vpc]
}


resource "google_compute_forwarding_rule" "backend_psc_ep" {
  depends_on = [
    google_compute_address.backend_pe_ip_address, google_compute_network.dbx_private_vpc
  ]
  region      = var.region
  project     = var.google_project
  name        = "${var.shared_name}-relay-endpoint"
  network     = google_compute_network.dbx_private_vpc.id
  ip_address  = google_compute_address.backend_pe_ip_address.id
  target      = var.relay_service_attachment
  load_balancing_scheme = "" #This field must be set to "" if the target is an URI of a service attachment. Default value is EXTERNAL
}

resource "google_compute_address" "backend_pe_ip_address" {
  name         = "${var.shared_name}-relay-ip"
  provider     = google
  project      = var.google_project
  region       = var.region
  subnetwork   = google_compute_subnetwork.backend_pe_subnetwork.name
  address_type = "INTERNAL"
}

resource "google_compute_forwarding_rule" "frontend_psc_ep" {
  depends_on = [
    google_compute_address.frontend_pe_ip_address
  ]
  region      = var.region
  name        = "${var.shared_name}-workspace-endpoint"
  project     = var.google_project
  network     = google_compute_network.dbx_private_vpc.id

  ip_address  = google_compute_address.frontend_pe_ip_address.id
  target      = var.workspace_service_attachment
  load_balancing_scheme = "" #This field must be set to "" if the target is an URI of a service attachment. Default value is EXTERNAL
}

resource "google_compute_address" "frontend_pe_ip_address" {
  name         = "${var.shared_name}-workspace-ip"
  provider     = google
  project      = var.google_project
  region       = var.region
  subnetwork   = google_compute_subnetwork.backend_pe_subnetwork.name
  address_type = "INTERNAL"
}

output "front_end_psc_status"{
  value = "Frontend psc status: ${google_compute_forwarding_rule.frontend_psc_ep.psc_connection_status}"
}

output "backend_end_psc_status"{
  value = "Backend psc status: ${google_compute_forwarding_rule.backend_psc_ep.psc_connection_status}"
}