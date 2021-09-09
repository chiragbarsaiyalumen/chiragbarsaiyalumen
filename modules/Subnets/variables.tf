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