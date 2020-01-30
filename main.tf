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
  network = "projects/${var.afrl-shared-host-project}/global/networks/${var.afrl-shared-host-network}"

  addons_config {
    httpLoadBalancing = {},
    horizontalPodAutoscaling = {},
    kubernetesDashboard = {
      "disabled" = true
    },
    istioConfig = {
      "disabled" = true
    }
  }
  node_config {
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

    labels = {
      foo = "bar"
    }

    tags = ["foo", "bar"]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}
