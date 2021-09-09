     terraform {
       backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = "CenturyLinkDevOps"

         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "elanco-demolab"
         }
       }
     }


#Below module is to manage custom VPC Network

module "VPC" {
    project         = "${var.project}"
    source          = "./modules/VPC"
    network         = "demo-elanco-vpc"
}

#Below module is to manage custom VPC Sub-Networks

module "Subnets-web" {
    source                          = "./modules/Subnets"
    project                         = "${var.project}"
    subnet                          = "web"
    ip_cidr_range                   = "10.0.1.0/24"
    region                          = "us-central1"
    network                         = "${module.VPC.network}"
}


module "Subnets-db" {
    source                          = "./modules/Subnets"
    project                         = "${var.project}"
    subnet                          = "db"
    ip_cidr_range                   = "10.0.3.0/24"
    region                          = "us-central1"
    network                         = "${module.VPC.network}"
}

module "Subnets-mgmt" {
    source                          = "./modules/Subnets"
    project                         = "${var.project}"
    subnet                          = "mgmt"
    ip_cidr_range                   = "10.0.4.0/24"
    region                          = "us-central1"
    network                         = "${module.VPC.network}"
}


module "Subnets-app" {
    source                          = "./modules/k8s Subnet"
    project                         = "${var.project}"
    subnet                          = "app"
    ip_cidr_range                   = "10.1.0.0/16"
    region                          = "us-central1"
    network                         = "${module.VPC.network}"
    ip_range_pods                   = "ip-range-pods"
    ip_range_pods_cidr_range        = "10.2.0.0/20"
    ip_range_services               = "ip-range-services"
    ip_range_services_cidr_range    = "10.3.0.0/20"
}

#Below modules created for provisioning indivisual Web servers without managed by any Load Balancers

/*
module "web-instance" {
    source                  = "./modules/Virtual Machines"
    project                 = "${var.project}"
    instance_name           = "web-instance"
    address                 = "10.0.1.4"
    subnet                  = "${module.Subnets-web.subnet}"
    region                  = "us-central1"
    zone                    = "us-central1-a"
    instance_machine_type   = "e2-micro"
    instance_image          = "centos-7-v20210817"
    env                     = "web"
    metadata_startup_script = file("startup.sh")
}

module "fw_rule_for_web" {

    source                  = "./modules/Firewall"
    project                 = "${var.project}"
    FW_Rule_name            = "allow-http-https-ports"
    network                 = "${module.VPC.network}"
    env                     = "web"
    protocol_type           = "tcp"
    ports                   = ["22","80","443"]
}

module "db-instance" {
    source                  = "./modules/Virtual Machines"
    project                 = "${var.project}"
    instance_name           = "db-instance"
    address                 = "10.0.3.4"
    subnet                  = "${module.Subnets-db.subnet}"
    region                  = "us-central1"
    zone                    = "us-central1-a"
    instance_machine_type   = "e2-micro"
    instance_image          = "centos-7-v20210817"
    env                     = "db"
    metadata_startup_script = file("startup.sh")
}

module "fw_rule_for_db" {

    source                  = "./modules/Firewall"
    project                 = "${var.project}"
    FW_Rule_name            = "allow-sql-db-ports"
    network                 = "${module.VPC.network}"
    env                     = "db"
    protocol_type           = "tcp"
    ports                   = ["1443"]
}

*/



#Below modules managing HTTP(S) Internal/external load balancers based on Instance group.


module "web-instance-template-group" {

    source                  =  "./modules/Instance-Template-Group"
    project                 = "${var.project}"
    subnet                  = "${module.Subnets-web.subnet}"
    region                  = "us-central1"
    zone                    = "us-central1-a"
    instance_machine_type   = "e2-micro"
    instance_image          = "centos-7-v20210817"
    env                     = "web"
    metadata_startup_script = file("startup.sh")
    instance_template_name  = "web"
    health_check_name       = "web-health-check"
    port_health_check       = "80"
    timeout_sec             = 2
    interval_sec            = 2
    healthy_threshold       = 5
    unhealthy_threshold     = 5
    instance-group-name     = "web"
    target_machines         = 2
}


module "HTTPS_LoadBalancer" {

    source                  = "./modules/HTTPS LoadBalancer"
    project                 = "${var.project}"
    LoadBalancer-name       = "web-hhtps"
    health-check            = ["${module.web-instance-template-group.health_check_id}"]
    instance-group-name     = "${module.web-instance-template-group.instance-group-name}"
    security_policy         = "${module.cloud-amor-policies-deny.security_policy}"
}

module "fw_rule_for_web" {

    source                  = "./modules/Firewall"
    project                 = "${var.project}"
    FW_Rule_name            = "allow-http-https-ports"
    network                 = "${module.VPC.network}"
    env                     = ["web"]
    source_ranges           = ["${module.HTTPS_LoadBalancer.loadbalancer-ip-addr}","35.191.0.0/16"]
    protocol_type           = "tcp"
    ports                   = ["80","443"]
}


#Below module can be used to spin up GKE cluster
/*
module "basic-gke-cluster" {
            source              = "./modules/GKE Cluster"
            project				= "${var.project}"
            cluster_name		= "k8s-basic"
            region				= "us-central1"
            zone				= ["us-central1-a","us-central1-b","us-central1-c"]
            network				= "${module.VPC.network}"
            subnet				= "${module.Subnets-app.subnet}"
            ip_range_pods       = "ip-range-pods"
            ip_range_services   = "ip-range-services"
            node-pool-name		= "node-pool-basic"
            machine_type		= "e2-micro"
            min_count			= 2
            max_count			= 3
            disk_size_gb		= 100
            disk_type			= "pd-standard"
            service_account		= "demo-elanco@host-project-demo-270820.iam.gserviceaccount.com"
            initial_node_count	= 2
}

*/

#Below module is to create Cloud Armor Policies

module "cloud-amor-policies-deny" {

    source              = "./modules/Cloud Armor"
    project				= "${var.project}"
    policy-name         = "policy-for-layer7-lb"
    action              = "deny(403)"
    priority            = 1000
    src_ip_ranges       = ["157.34.121.139"]
    #is_enable           = true
    versioned_expr      = "SRC_IPS_V1"
    #rule_visibility     = "STANDARD"
}
