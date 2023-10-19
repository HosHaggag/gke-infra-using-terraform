resource "google_compute_firewall" "managment-firewall-Ingress" {
  name    = "managment-firewall-ingress"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  target_service_accounts = ["${var.service_account}"]
  target_tags = ["managment-instance"]
    direction = "INGRESS"
  }


resource "google_compute_firewall" "managment-firewall-Egress" {
    name    = "managment-firewall-egress"
    network = google_compute_network.vpc_network.name
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    destination_ranges = [
    "${google_compute_subnetwork.workload_subnet.ip_cidr_range}}" , # ip range of workload subnet
    "199.36.153.4/30" , # ip ranges of artifact registry
     "199.36.153.8/30"]
    target_service_accounts = ["${google_service_account.service_account.email}"]
    direction = "EGRESS"
    }

resource "google_compute_firewall" "workload-firewall-Ingress" {
    name    = "workload-firewall-ingress"
    network = google_compute_network.vpc_network.name
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = [""]
    target_service_accounts = ["${google_service_account.service_account.email}"]
    target_tags = ["workload-instance"]
    direction = "INGRESS"
    }

