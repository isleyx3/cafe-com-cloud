terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "4.66.0"
    }
  }
}

provider "google" {
  project = "poc-ipnet-cloud"
  # Configuration options
}

provider "google-beta" {
  project = "poc-ipnet-cloud"
  # Configuration options
}