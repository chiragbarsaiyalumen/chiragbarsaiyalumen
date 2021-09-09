output "VPC-ID" {
    value = "${module.VPC.network}"
}

output "Subnets-web" {
  value = "${module.Subnets-web.subnet}"
}

output "Subnets-app" {
  value = "${module.Subnets-app.subnet}"
}

output "Subnets-db" {
  value = "${module.Subnets-db.subnet}"
}

output "Subnets-mgmt" {
  value = "${module.Subnets-mgmt.subnet}"
}
/*
output "web_instance_name" {
  value = "${module.web-instance.instance_name}"
}

output "db_instance_name" {
  value = "${module.db-instance.instance_name}"
}

*/