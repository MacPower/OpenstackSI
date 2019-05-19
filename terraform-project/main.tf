provider "google" {
 credentials = "${file("juju-openstack-isep.json")}"
 project     = "juju-openstack-isep"
 region      = "europe-west2"
}


// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "deployment-vm" {
    name         = "deployment-vm-${random_id.instance_id.hex}"
    machine_type = "n1-standard-1"
    zone         = "europe-west2-c"
    can_ip_forward = true
    boot_disk {
    initialize_params {
        image = "ubuntu-1804-bionic-v20190514"
        size  = 10
        }
    }

 metadata_startup_script = "${file("./bootscript_deployment-vm.sh")}"

 network_interface {
   network = "${google_compute_network.custom-network.name}"
   subnetwork = "${google_compute_subnetwork.internal-subnet.name}"
   access_config {
     // Include this section to give the VM an external ip address
   }
 }

provisioner "file" {
    source      = "ssh/id_rsa"
    destination = "/tmp/id_rsa"
}
provisioner "file" {
    source      = "ssh/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"
}
provisioner "file" {
    source      = "ssh/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"
}

provisioner "file" {
    source      = "ssh/install_key.sh"
    destination = "/tmp/install_key.sh"
}
provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_key.sh",
      "/tmp/install_key.sh",
    ]
  }
provisioner "remote-exec" {
    inline = [
      "export HOST0=${google_compute_instance.host-vm.network_interface.0.network_ip}",
      "export HOST1=${google_compute_instance.host-vm-2.network_interface.0.network_ip}",
    ]
  }

connection {
        type     = "ssh"
        user     = "thomasbuatois"
        private_key = "${file("/Users/thomasbuatois/.ssh/id_rsa")}"
    }
 tags = ["ssh"]
}

resource "google_compute_instance" "host-vm" {
    name         = "host-vm-${random_id.instance_id.hex}"
    machine_type = "n1-standard-2"
    zone         = "europe-west2-c"
    can_ip_forward = true
    boot_disk {
    initialize_params {
        image = "ubuntu-1804-bionic-v20190514"
        size  = 50
        }
    }

 metadata_startup_script = "${file("./bootscript_host-vm.sh")}"

 network_interface {
   network = "${google_compute_network.custom-network.name}"
   subnetwork = "${google_compute_subnetwork.internal-subnet.name}"
 }

 tags = ["internal"]
}
resource "google_compute_instance" "host-vm-2" {
    name         = "host-vm-2-${random_id.instance_id.hex}"
    machine_type = "n1-standard-2"
    zone         = "europe-west2-c"
    can_ip_forward = true
    boot_disk {
    initialize_params {
        image = "ubuntu-1804-bionic-v20190514"
        size  = 50
        }
    }

 metadata_startup_script = "${file("./bootscript_host-vm.sh")}"

 network_interface {
   network = "${google_compute_network.custom-network.name}"
   subnetwork = "${google_compute_subnetwork.internal-subnet.name}"
 }


 tags = ["internal"]
}

resource "google_compute_network" "custom-network" {
  name                    = "custom-network"
  auto_create_subnetworks = "false"
}
resource "google_compute_subnetwork" "internal-subnet" {
  name          = "internal-subnet"
  ip_cidr_range = "192.168.0.0/24"
  network       = "${google_compute_network.custom-network.self_link}"
}

resource "google_compute_firewall" "ssh-access" {
  name    = "allow-ssh"
  network = "${google_compute_network.custom-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  // Allow traffic from everywhere to instances with an ssh tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}
resource "google_compute_firewall" "allow-internal-traffic" {
    name          = "allow-internal-traffic"
    network       = "${google_compute_network.custom-network.name}"
    source_ranges = ["192.168.0.0/24"]
    target_tags   = ["internal"]
    allow {
        protocol = "icmp"
    }
    
    allow {
        protocol = "tcp"
	ports = ["1-65535"]
    }

    allow {
        protocol = "udp"
	ports = ["1-65535"]
    }
}

output "ip_deployment-vm" {
  value = "${google_compute_instance.deployment-vm.network_interface.0.access_config.0.nat_ip}"
}
output "ip_host-vm" {
  value = "${google_compute_instance.host-vm.network_interface.0.network_ip}"
}
output "ip_host-vm-2" {
  value = "${google_compute_instance.host-vm-2.network_interface.0.network_ip}"
}