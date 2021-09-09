resource "google_compute_subnetwork" "k8s-subnet" {

  project       = "${var.project}"
  name          = "${var.subnet}"
  ip_cidr_range = "${var.ip_cidr_range}"
  region        = "${var.region}"
  network       = "${var.network}"
  secondary_ip_range {
                      range_name    = "${var.ip_range_pods}"
                      ip_cidr_range = "${var.ip_range_pods_cidr_range}"
                      }

  secondary_ip_range {
                      range_name    = "${var.ip_range_services}"
                      ip_cidr_range = "${var.ip_range_services_cidr_range}"
                      }
}