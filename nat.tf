resource "google_compute_router" "router" {
  name    = "cr-cafe-microservicos-southamerica-east1"
  project = "poc-ipnet-cloud"
  region  = "southamerica-east1"
  network = module.vpc-network.network_name
}

resource "google_compute_router_nat" "nat" {
  name                                = "nat-vpc-network-cafe"
  project                             = "poc-ipnet-cloud"
  region                              = "southamerica-east1"
  router                              = google_compute_router.router.name
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option              = "AUTO_ONLY"
  enable_endpoint_independent_mapping = false
  min_ports_per_vm                    = 64

  log_config {
    enable = false
    filter = "ALL"
  }
}