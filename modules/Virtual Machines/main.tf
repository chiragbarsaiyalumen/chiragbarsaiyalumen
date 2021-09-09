resource "google_compute_address" "instance_ip" {
  name          = "${var.instance_name}"
  address       = "${var.address}"
  address_type  = "INTERNAL"
  project       = "${var.project}"
  subnetwork    = "${var.subnet}"
  region        = "${var.region}"
}

resource "google_compute_instance" "Instance" {

    #Required field segment
    name                = "${var.instance_name}"
    machine_type        = "${var.instance_machine_type}"
    boot_disk           {
                            device_name = "${var.instance_name}"
                            initialize_params {
                            image = "${var.instance_image}"
                            type = "${var.boot_disktype}"
                            size = "${var.boot_disksize}"
                            }
                        }
    network_interface   {
                            subnetwork          = "${var.subnet}"
                            subnetwork_project  = "${var.project}"
                            network_ip          = google_compute_address.instance_ip.self_link
                            #Omiting to ensure that the instance is not accessible from the Internet
                            #access_config {}
                        }

    #Optional field segment
    zone                = "${var.zone}"
    can_ip_forward      = false
    deletion_protection = false
    labels              = {
                            name = "${var.instance_name}"
                            env  = "${var.env}"
                        }
    scheduling              {
                            automatic_restart   = true
                            on_host_maintenance = "MIGRATE"
                            }

    tags                  = ["${var.instance_name}","${var.env}" ]

    metadata_startup_script = "${var.metadata_startup_script}"
}