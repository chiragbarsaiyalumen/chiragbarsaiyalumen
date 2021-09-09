output "subnet" {

    value = google_compute_subnetwork.k8s-subnet.name
}

output "subnet-CIDR-Range" {

    value = google_compute_subnetwork.k8s-subnet.ip_cidr_range
}