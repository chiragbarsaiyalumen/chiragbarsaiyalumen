resource "google_compute_subnetwork" "demo-elanco-subnet" {

  project       = "${var.project}"
  name          = "${var.subnet}"
  ip_cidr_range = "${var.ip_cidr_range}"
  region        = "${var.region}"
  network       = "${var.network}"
}