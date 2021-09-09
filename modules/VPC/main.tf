resource "google_compute_network" "demo-elanco-vpc" {
  project                 = "${var.project}"
  name                    = "${var.network}"
  description             = "This is modeule which can be reuse to provision n VPC's"
  auto_create_subnetworks = false
  routing_mode            = "${var.routing_mode}"
  mtu                     = "${var.mtu}"
}