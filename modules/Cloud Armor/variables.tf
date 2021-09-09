variable "policy-name" {
    type = string
}

variable "action" {}

variable "priority" {}

variable "versioned_expr" {}

variable "src_ip_ranges" {

    type = list(string)
}

/*
variable "is_enable" {

    type = bool
}

variable "rule_visibility" {}

*/
variable "project" {}