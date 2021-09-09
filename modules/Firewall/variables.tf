variable "project" {}

variable "FW_Rule_name" {
    type = string
}

variable "network" {}

variable "env" {
    type = list(string)
}

variable "protocol_type" {
        type    = string
}

variable "ports" {
    type    = list(string)
}


variable "source_ranges" {

    type = list(string)
}

