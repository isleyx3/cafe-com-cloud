
module "vpc-network" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "5.0.0"

  network_name                           = "vpc-network-cafe"
  auto_create_subnetworks                = false
  routing_mode                           = "GLOBAL"
  project_id                             = "poc-ipnet-cloud"
  delete_default_internet_gateway_routes = false
  mtu                                    = 1460
  shared_vpc_host                        = false
}

module "subnet-network" {
  source = "terraform-google-modules/network/google//modules/subnets"

  project_id   = "poc-ipnet-cloud"
  network_name = module.vpc-network.network_name
  subnets      = local.subnets

  secondary_ranges = local.secondary_ranges

  depends_on = [
    module.vpc-network
  ]
}