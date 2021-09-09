output "security_policy" {

    value = google_compute_security_policy.cloud-armor-policy.self_link
}