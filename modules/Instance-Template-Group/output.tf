output "instance-template-id" {

    value = google_compute_instance_template.instance_template.id
}

output "instance-group-name" {

    value = google_compute_instance_group_manager.instance_group_manager.self_link
}

/*
output "instance-group-id" {

    value = google_compute_instance_group_manager.instance_group_manager.self_link
}
*/

output "health_check_id" {

    value = google_compute_health_check.staging_health.id
}