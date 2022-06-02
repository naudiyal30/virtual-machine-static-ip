provider "google" {
  project = var.project_id
}

 module "payment-service" {
  source              = "./modules/payment-service"
  project_id           = var.project_id
  location            = var.location
#  gke_subnet          = var.gke_subnet
  vpc_network         = var.vpc_network
  machine_type       = var.machine_type
}
