resource "google_compute_network" "vpc_network" {
  project                 = var.vpc_project
  name                    = var.vpc_name
  auto_create_subnetworks = var.vpc_auto_create_subnet
}

#firewall-rule

resource "google_compute_firewall" "firewall_rule" {
  name          = var.firewall_name          
  network       = var.firewall_network       
  priority      = var.firewall_priority     
  direction     = var.firewall_direction     
  project       = var.firewall_project       
  source_ranges = var.firewall_source_ranges 

  allow {
    protocol = var.firewall_protocol
    ports    = var.firewall_ports   
  }

  target_tags = var.firewall_tags
}

