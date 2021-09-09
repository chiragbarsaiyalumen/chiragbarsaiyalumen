variable "instance_name" {
    type    = string
}

variable "instance_machine_type" {
    type    = string
}

variable "instance_image" {
    type    = string
}

variable "boot_disktype" {
    type    = string
    default = "pd-standard"
}

variable "boot_disksize" {
    type    = string
    default = "50"
}

variable "subnet" {}

variable "address" {}

variable "zone" {
    type    = string
}

variable "env" {
    type    = string
}

variable "project" {}

variable "region" {}

variable "metadata_startup_script" {}