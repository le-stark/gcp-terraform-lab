resource "google_compute_backend_service" "default" {
  name = "backend-service-manhlnd1-global-dev-lab01"
  # region = "us-central1"
  health_checks = [var.healthz]
  protocol = "HTTP"
  
  load_balancing_scheme = "EXTERNAL_MANAGED"
  locality_lb_policy = "ROUND_ROBIN"
  port_name = "loadbalancerhttp"
  backend {
    group = var.instance_group_url
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
    max_utilization = 0.7
  }

}