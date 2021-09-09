resource "google_compute_backend_service" "backend" {
  name        = "${local.name_suffix}-backend-service"
  port_name   = "${var.port_name}"
  protocol    = "${var.protocol}"
  timeout_sec = 30
  backend        {

      group = "${replace(var.instance-group-name, "Manager","")}"
  }
  health_checks = "${var.health-check}"
  security_policy = "${var.security_policy}"
}


resource "google_compute_url_map" "url-map" {
  name            = "${local.name_suffix}-url-map-target-proxy"
  default_service = google_compute_backend_service.backend.id

host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.backend.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.backend.id
    }
  }
}

resource "google_compute_managed_ssl_certificate" "SSL-cert" {
  name = "${local.name_suffix}-ssl-cert"

  managed {
    domains = ["elancotest.hybridcloudsupport.net"]
  }
}

resource "google_compute_target_https_proxy" "target-proxy" {
  name        = "${local.name_suffix}-target-proxy"
  url_map     = google_compute_url_map.url-map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.SSL-cert.id]
}

### Forwarding Rule
resource "google_compute_global_forwarding_rule" "https" {
  project    = "${var.project}"
  name       = "${local.name_suffix}"
  target     = google_compute_target_https_proxy.target-proxy.id
  port_range = "443"
}

data "google_dns_managed_zone" "dnszone" {

    name    = "hybridcloudsupport"
}

resource "google_dns_record_set" "set" {
  name         = "hybridcloudsupport.net."
  type         = "A"
  ttl          = 3600
  managed_zone = data.google_dns_managed_zone.dnszone.name
  rrdatas      = [google_compute_global_forwarding_rule.https.ip_address]
}