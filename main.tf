resource "google_compute_network" "vpc_network" {
  name                    = "cafe-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "default" {
  name          = "cafe-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
}


# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "cafe-vm"
  machine_type = "f1-micro"
  zone         = "us-east1-a"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  # Install Flask
  metadata_startup_script = "sudo apt-get update; sudo /bin/sh -c '$(curl -fsSL https://raw.githubusercontent.com/turbot/steampipe/main/install.sh)'"

  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "steampipe-port" {
  name = "allow-steampipe"
  allow {
    ports    = ["9194"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1001
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}