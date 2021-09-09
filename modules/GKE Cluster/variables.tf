variable "project" {}

variable "cluster_name" {}

variable "region" {}

variable "zone" {

    type = list(string)
}

variable "network" {}

variable "subnet" {}

variable "http_load_balancing" {

    type = bool
    default = false
}

variable "horizontal_pod_autoscaling" {

    type = bool
    default = true
}

variable "network_policy" {

    type = bool
    default = false
}

variable "node-pool-name" {

    type = string
}

variable "machine_type" {

    type = string
}

variable "min_count" {}

variable "max_count" {}

variable "disk_size_gb" {}

variable "disk_type" {}

variable "service_account" {}

variable "preemptible" {

    type = bool
    default = false

}

variable "initial_node_count" {}

variable "image_type" {

    type = string
    default = "COS"
}

variable "ip_range_pods" {}

variable "ip_range_services" {}