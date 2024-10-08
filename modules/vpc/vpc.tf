resource "google_compute_network" "dbx_private_vpc" {
  project                 = var.google_project
  name                    = "${var.shared_name}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "${var.shared_name}-subnet"
  ip_cidr_range = var.nodes_ip_cidr_range
  region        = var.region
  network       = google_compute_network.dbx_private_vpc.id
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.pod_ip_cidr_range
  }
  secondary_ip_range {
    range_name    = "svc"
    ip_cidr_range = var.service_ip_cidr_range
  }
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "${var.shared_name}-router"
  region  = google_compute_subnetwork.network-with-private-secondary-ip-ranges.region
  network = google_compute_network.dbx_private_vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.shared_name}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

