data "google_client_config" "default" {}

provider "google" {

    project = "${var.project}"
}

provider "kubernetes" {

    token  = data.google_client_config.default.access_token
}