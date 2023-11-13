provider "google" {
  credentials = file("tf-key.json")
  project = "my-project-manhlnd1"
  region = "us-central1"
}

module "network" {
  source = "./network"

}

module "instance-group" {
  source = "./instances-group"
  source_image_name = var.source_image_name
  network_name = module.network.network_name
  subnetwork_name = module.network.subnetwork_name
  depends_on = [ module.network ]
}

module "health-check" {
  source = "./health-check"
  # named_port = module.instance-group.named_port
}

module "back-end-service" {
  source = "./back-end-service"
  healthz = module.health-check.healthz
  instance_group_url = module.instance-group.instance_group_url
  # named_port = module.instance-group.named_port
}

module "http-load-balancing" {
  source = "./http-load-balancing"
  backend_service_url = module.back-end-service.backend_service_url
  static_ip = var.static_ip
}

module "notification_monitoring" {
  source = "./notification_monitoring"
}

