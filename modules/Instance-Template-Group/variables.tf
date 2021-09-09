variable "instance_template_name" {}

variable "env" {
    type = string
}

variable "instance_machine_type" {}

variable "instance_image" {}

variable "subnet" {}

variable "project" {}

variable "region" {}

variable "metadata_startup_script" {}

variable "zone" {}

variable "health_check_name" {}

variable "port_health_check" {}

variable "timeout_sec" {}

variable "interval_sec" {}

variable "healthy_threshold" {}

variable "unhealthy_threshold" {}

variable "instance-group-name" {}

variable "target_machines" {}
