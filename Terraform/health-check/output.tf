output "healthz" {
  value = google_compute_health_check.autohealing.id
}