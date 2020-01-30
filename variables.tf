variable "cluster_name" {
  type = string
}

variable "zone" {
  type = string
}

variable "display_name" {

}

variable "project_id" {

}

variable "afrl-shared-host-project" {
  description = "name of the project hosting the shared vpc network"
}

variable "afrl-shared-host-network" {
  description = "name of the network in the shared vpc"
}

variable "afrl-shared-host-subnet" {
  description = "name of the subnetwork in the shared vpc"
}

variable "afrl-pods-subnet" {
  description = "name of the subnetwork to use for GKE pods"
}

variable "afrl-services-subnet" {
  description = "name of the subnetwork to use for GKE services"
}