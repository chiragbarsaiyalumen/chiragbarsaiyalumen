resource "google_compute_security_policy" "cloud-armor-policy" {
  name                       = "${var.policy-name}"
  project                    = "${var.project}"
  rule {
    action              = "${var.action}"
    priority            = "${var.priority}"
    match               {
                        versioned_expr = "${var.versioned_expr}"
                        config {
                                src_ip_ranges = "${var.src_ip_ranges}"
                                }
                        }
    description = "var.action access to IPs in var.src_ip_ranges "

    
        }

    rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "${var.versioned_expr}"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
  /*
  adaptive_protection_config {

                                layer_7_ddos_defense_config {
                                    enable = "${var.is_enable}"
                                    rule_visibility = "${var.rule_visibility}"
                                    }
                                }
   */                             
}