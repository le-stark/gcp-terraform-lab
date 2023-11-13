resource "google_compute_global_forwarding_rule" "frontend_config" {
  name = "frontend-config-manhlnd1-global-dev-lab01"
#   region = "us-central1"
  # ip_address = "34.36.25.102" em đã gắn được static IP. Do ban đầu không đợi khoảng 5ph để gcp tiến hành gắn static ip
  ip_address = var.static_ip
  ip_protocol = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range = "80"

  target = google_compute_target_http_proxy.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name = "target-proxy-manhlnd1-uscentral-dev-lab01"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name = "url-map-manhlnd1-uscentral-dev-lab01"
  default_service = var.backend_service_url
}