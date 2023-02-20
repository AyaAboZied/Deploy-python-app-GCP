resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}


resource "google_compute_network" "vpc" {
  project                 = var.vpc_project
  name                    = var.vpc_name
  auto_create_subnetworks = var.vpc_auto_create_subnet
  mtu                     = var.vpc_mtu
}
