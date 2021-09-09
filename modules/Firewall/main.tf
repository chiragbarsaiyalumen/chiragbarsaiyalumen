resource "google_compute_firewall" "FW_Rule_name" {
  project     = "${var.project}"
  name        = "${var.FW_Rule_name}"
  network     = "${var.network}"
  description = "Creates firewall rule targeting tagged instances"

  allow {
            protocol  = "${var.protocol_type}"
            ports     = "${var.ports}"
        }
  source_ranges = "${var.source_ranges}"
  target_tags   = "${var.env}"
}