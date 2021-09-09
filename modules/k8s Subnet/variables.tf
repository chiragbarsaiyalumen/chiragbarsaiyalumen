variable "ip_cidr_range" {
    type = string
}

variable "region" {
    type = string
    default = "us-central1"
}

variable "network" {}

variable "project" {}

variable "subnet" {

    type = string
}

variable "ip_range_pods" {}

variable "ip_range_pods_cidr_range" {}

variable "ip_range_services" {}

variable "ip_range_services_cidr_range" {}
