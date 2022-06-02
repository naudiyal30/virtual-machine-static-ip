resource "google_compute_address" "static-ip2" {
  name = "static2"
  address_type = "EXTERNAL"
  region = var.location
}

data "template_file" "nodejs-startup" {
  template = file("${path.module}/templates/nodejs-startup.sh")
  vars     = local.template_vars
}

resource "google_compute_instance" "vm_instance" {
  name         = "payment-service"
  machine_type = var.machine_type
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  metadata_startup_script = file("./nodejs-startup.sh")

  
  network_interface {
    access_config {
       nat_ip = google_compute_address.static-ip2.address
    }
  #  subnetwork = var.gke_subnet
    network    = var.vpc_network
  }

metadata_startup_script = data.template_file.nodejs-startup.rendered
}
