#create bigtable resource

resource "google_bigtable_instance" "development-instance" {
  name          = "tf-instance"
  instance_type = "DEVELOPMENT"
  display_name = var.display_name
  project = var.project_id

  cluster {
    cluster_id   = var.cluster_name
    zone         = var.zone
    storage_type = "HDD"
  }
}

resource "google_container_cluster" "afrl-janus-cluster" {
  name               = "afrl-janus-cluster-01"
  location           = "us-central1-f"
  initial_node_count = 3

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
  addons_config {
  http_load_balancing {
    disabled = true
  }

  horizontal_pod_autoscaling {
    disabled = true
  }
}

  logging_service = "logging.googleapis.com"
  monitoring_service = "monitoring.googleapis.com"
  network = "projects/${var.afrl-shared-host-project}/global/networks/${var.afrl-shared-host-network}"
  subnetwork = "projects/${var.afrl-shared-host-project}/regions/us-central1/subnetworks/${var.afrl-shared-host-subnet}"

  node_pool {
    name = "default-pool"
    node_config {
      machine_type = "n1-standard-4"
      image_type = "COS"
      disk_type = "pd-standard"
      disk_size_gb = 10
      oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/bigtable.data",
      "https://www.googleapis.com/auth/bigtable.admin",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
      ]
      metadata = {
        disable-legacy-endpoints = "true"
      }
      tags = ["afrl", "wbi"]
      labels = {
        env = "dev"
      }

    }

  }
  ip_allocation_policy {
    use_ip_aliases = true
    cluster_secondary_range_name = var.pods_subnet_name
    services_secondary_range_name = var.services_subnet_name
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}