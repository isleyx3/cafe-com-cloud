terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "4.66.0"
    }
  }
}

provider "google" {
  # Configuration options
}

provider "google-beta" {
  # Configuration options
}