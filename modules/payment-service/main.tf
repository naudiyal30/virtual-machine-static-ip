resource "google_compute_address" "static-ip" {
  name = "static"
  address_type = "EXTERNAL"
  region = us-west1
}

resource "google_compute_instance" "vm_instance" {
  name         = "payment-service"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

 # metadata_startup_script = file("./nodejs-startup.sh")

  network_interface {

    access_config {
        nat_ip = google_compute_address.static-ip.address
    }
  }
}
