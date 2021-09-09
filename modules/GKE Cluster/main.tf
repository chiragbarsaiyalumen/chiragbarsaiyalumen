module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = "${var.project}"
  name                       = "${var.cluster_name}"
  region                     = "${var.region}"
  zones                      = "${var.zone}"
  network                    = "${var.network}"
  subnetwork                 = "${var.subnet}"
  ip_range_pods              = "${var.ip_range_pods}"
  ip_range_services          = "${var.ip_range_services}"
  http_load_balancing        = "${var.http_load_balancing}"
  horizontal_pod_autoscaling = "${var.horizontal_pod_autoscaling}"
  network_policy             = "${var.network_policy}"

  node_pools = [
    {
      name                      = "${var.node-pool-name}"
      machine_type              = "${var.machine_type}"
      #node_locations            = "us-central1-b,us-central1-c"
      min_count                 = "${var.min_count}"
      max_count                 = "${var.max_count}"
      #local_ssd_count           = 0
      disk_size_gb              = "${var.disk_size_gb}"
      disk_type                 = "${var.disk_type}"
      image_type                = "${var.image_type}"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "${var.service_account}"
      preemptible               = "${var.preemptible}"
      initial_node_count        = "${var.initial_node_count}"
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    "${var.node-pool-name}" = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    "${var.node-pool-name}" = {
      "${var.node-pool-name}" = true
    }
  }

  node_pools_metadata = {
    all = {}

    "${var.node-pool-name}" = {
      node-pool-metadata-custom-value = "${var.node-pool-name}"
    }
  }

/*
  node_pools_taints = {
    all = []

    "${var.node-pool-name}" = [
      {
        key    = "${var.node-pool-name}"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }
*/

  node_pools_tags = {
    all = []

    "${var.node-pool-name}" = [
      "${var.node-pool-name}",
    ]
  }
}