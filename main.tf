resource "google_compute_instance" "default" {
  name          = "virtual-machine-from-terraform"
  machine_type  = "f1-micro"
  zone          = "asia-southeast1-a"

  boot_disk {
    initialize_params {
      //image = "ubuntu-os-cloud/ubuntu-2004-lts"
      image= "debian-cloud/debian-9"
      size = 40
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Avenue Code is the leading software consulting agency focused on delivering end-to-end development solutions for digital transformation across every vertical. We pride ourselves on our technical acumen, our collaborative problem-solving ability, and the warm professionalism of our teams.!</h1></body></html>' | sudo tee /var/www/html/index.html"

    // Apply the firewall rule to allow external IPs to access this instance
    tags = ["http-server", "https-server"]
   metadata = {
    ssh-keys = "medival:${file("id_rsa.pub")}"
  }
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}