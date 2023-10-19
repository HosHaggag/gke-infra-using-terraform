



module "network" {
    source = "./network"
    managment-region = "us-central1"
    workload-region = "us-east1"
    management-subnet = "10.1.0.0/29"
    workload-subnet = "192.168.10.0/24"
    project_id = var.project_id
    service_account = var.tf_service_account
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = module.network.main_vpc
    subnetwork = module.network.managment_subnet
    access_config {
    }
  }
}