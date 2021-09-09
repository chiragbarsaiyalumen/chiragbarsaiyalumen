variable "LoadBalancer-name" {}

variable "port_name" {

    default = "http"
}

variable "protocol" {

    default = "HTTP"
}

variable "health-check" {}

variable "instance-group-name" {}

variable project {}

variable "security_policy" {}