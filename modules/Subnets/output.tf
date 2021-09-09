output "subnet" {

    value = google_compute_subnetwork.demo-elanco-subnet.id
}

output "subnet-CIDR-Range" {

    value = google_compute_subnetwork.demo-elanco-subnet.ip_cidr_range
}