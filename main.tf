module "vpc" {
  source                 = "./vpc"
  vpc_project            = "mercurial-time-233114"
  vpc_name               = "vpc-network"
  vpc_auto_create_subnet = false
}

module "firewalls" {
  source                 = "./vpc"
  firewall_name          = "allow-ssh"
  firewall_network       = module.vpc.vpc_name
  firewall_priority      = 1000
  firewall_direction     = "INGRESS"
  firewall_project       = module.vpc.vpc_project
  firewall_source_ranges = ["35.235.240.0/20"]
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_tags          = ["private"]
  depends_on = [
    module.vpc,
    module.restricted_subnet
  ]
}

module "management_subnte" {
  source         = "./subnets"
  subnet_name    = "management-subnet"
  subnet_cider   = "10.0.1.0/24"
  subnet_region  = "asia-east1"
  subnet_network = module.vpc.vpc_id
  subnet_project = module.vpc.vpc_project
  depends_on = [
    module.vpc
  ]
}

module "restricted_subnet" {
  source         = "./subnets"
  subnet_name    = "restricted-subnet"
  subnet_cider   = "10.0.2.0/24"
  subnet_region  = "asia-east1"
  subnet_network = module.vpc.vpc_id
  subnet_project = module.vpc.vpc_project
  depends_on = [
    module.vpc
  ]
}

module "nat" {
  source         = "./nat-gateway"
  router_name    = "my-router"
  router_region  = module.management_subnte.subnet_region
  router_network = module.vpc.vpc_name

  nat_router_name            = "gateway-router"
  nat_router_subnetwork_name = module.management_subnte.subnet_name
}

module "private_vm" {
  source                  = "./vm"
  service_account_id      = "managment-cluster"
  service_account_project = module.vpc.vpc_project
  service_account_role    = "roles/container.admin"
  vm_name                 = "my-vm"
  vm_type                 = "f1-micro"
  vm_zone                 = "asia-east1"
  vm_project              = "mercurial-time-233114"
  vm_tags                 = ["private"]
  vm_network              = "management-subnet"
  vm_image                = "ubuntu-os-cloud/ubuntu-2204-lts" #"custom-img-nginx"
  depends_on = [
    module.management_subnte
  ]
}
