variable "network" {
  type = string
}

variable "mtu" {

  type = number
  default = 1460
}

variable "routing_mode" {
  type = string
  default = "GLOBAL"
}

variable "project" {}