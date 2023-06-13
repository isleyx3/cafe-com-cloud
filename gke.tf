data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                      = "poc-ipnet-cloud"
  master_global_access_enabled    = false
  kubernetes_version              = "1.24.12-gke.500"
  name                            = "gke-microservicos"
  region                          = "southamerica-east1"
  regional                        = true
  zones                           = ["southamerica-east1-a", "southamerica-east1-b", "southamerica-east1-c"]
  network                         = "vpc-network-cafe"
  subnetwork                      = "sb-spoke-cafe-southamerica-east1"
  ip_range_pods                   = "sip-pods-gke-cafe"
  ip_range_services               = "sip-services-gke-cafe"
  network_project_id              = "poc-ipnet-cloud"
  http_load_balancing             = true
  network_policy                  = false
  horizontal_pod_autoscaling      = true
  filestore_csi_driver            = false
  enable_shielded_nodes           = true
  enable_private_endpoint         = false
  enable_private_nodes            = true
  remove_default_node_pool        = true
  default_max_pods_per_node       = 10
  create_service_account          = false
  release_channel                 = "REGULAR"
  maintenance_start_time          = "02:00"
  master_ipv4_cidr_block          = "192.168.11.0/28"
  datapath_provider               = "ADVANCED_DATAPATH"
  enable_vertical_pod_autoscaling = true
  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "Acesso Provisório"
    }
  ]

  cluster_autoscaling = {
    enabled       = true
    min_cpu_cores = 1
    max_cpu_cores = 1
    min_memory_gb = 1
    max_memory_gb = 1
    gpu_resources = []
    auto_repair   = true
    auto_upgrade  = true
  }

  node_pools = [
    {
      name            = "npl-cafe"
      machine_type    = "e2-micro"
      node_locations  = "southamerica-east1-a,southamerica-east1-b,southamerica-east1-c"
      min_count       = 0
      max_count       = 1
      local_ssd_count = 0
      disk_size_gb    = 70
      disk_type       = "pd-standard"
      image_type      = "COS_CONTAINERD"
      enable_gcfs     = false
      auto_repair     = true
      auto_upgrade    = true
      preemptible     = true
      node_count      = 1
      autoscaling     = false
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

    npl-cafe = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }

  node_pools_metadata = {
    all = {}
  }

  depends_on = [ 
    module.vpc-network,
    module.subnet-network
   ]

}