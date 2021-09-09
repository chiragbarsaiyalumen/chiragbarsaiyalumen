resource "google_compute_instance_template" "instance_template" {

    name                = "${var.instance_template_name}"
    project             = "${var.project}"
    description         = "This Instance Template will help defining image for target backend machines"
    region              = "${var.region}"
    tags                = ["${var.env}" ]
    labels              = {
                            env  = "${var.env}"
                        }
    machine_type        = "${var.instance_machine_type}"
    can_ip_forward      = false
    scheduling          {
                        automatic_restart       = true
                        on_host_maintenance     = "MIGRATE"
                        }
    disk                {
                        source_image      = "${var.instance_image}"
                        auto_delete       = true
                        boot              = true
                        }
    network_interface   {
                            subnetwork          = "${var.subnet}"
                            subnetwork_project  = "${var.project}"
                            #Omiting to ensure that the instance is not accessible from the Internet
                            access_config {}
                        }
    metadata_startup_script = "${var.metadata_startup_script}"

}

resource "google_compute_health_check" "staging_health" {
  project             = "${var.project}"
  name                = "${var.health_check_name}"
  tcp_health_check      {
                        port = "${var.port_health_check}"
                        }
  timeout_sec         = "${var.timeout_sec}"
  check_interval_sec  = "${var.interval_sec}"
  healthy_threshold   = "${var.healthy_threshold}"
  unhealthy_threshold = "${var.unhealthy_threshold}"
}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  name                = "${var.instance-group-name}"
  project             = "${var.project}"
  version             {
    name              = "${var.instance_template_name}"
                          instance_template = google_compute_instance_template.instance_template.id
                      }
  base_instance_name = "${var.instance-group-name}"
  zone               = "${var.zone}"
  target_size        = "${var.target_machines}"
  auto_healing_policies {
    health_check      = google_compute_health_check.staging_health.id
    initial_delay_sec = 300
                        }
}