locals {
  subnets = [
    {
      subnet_name           = "sb-spoke-cafe-southamerica-east1"
      subnet_ip             = "192.168.10.0/24"
      subnet_region         = "southamerica-east1"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = "Subnet localizada na região southamerica-east1."
    }
  ]

  secondary_ranges = {
    sb-spoke-cafe-southamerica-east1 = [
      {
        range_name    = "sip-pods-gke-cafe"
        ip_cidr_range = "172.16.8.0/24"
      },
      {
        range_name    = "sip-services-gke-cafe"
        ip_cidr_range = "172.16.9.0/26"
      },

    ]
  }
}
