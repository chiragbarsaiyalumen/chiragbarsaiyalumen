output "instance_name" {
    value = google_compute_instance.Instance.name
}

output "instance_machine_type" {
    value = google_compute_instance.Instance.machine_type
}