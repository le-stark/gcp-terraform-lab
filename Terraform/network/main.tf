resource "google_compute_network" "vpc_network" {
  name                    = "vpc-manhlnd1-uscentral-dev-lab01"
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "subnetwork-manhlnd1-uscentral-dev-lab01"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "internal_firewall" {
  name    = "firewall-manhlnd1-uscentral-dev-lab01"
  network = google_compute_network.vpc_network.name

  source_ranges = [google_compute_subnetwork.vpc_subnetwork.ip_cidr_range]
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_firewall" "ssh_firewall" {
  name    = "ssh-firewall-manhlnd1-uscentral-dev-lab01"
  network = google_compute_network.vpc_network.name

  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "healthcheck_firewall" {
  name    = "healthcheck-firewall-manhlnd1-uscentral-dev-lab01"
  network = google_compute_network.vpc_network.name

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}