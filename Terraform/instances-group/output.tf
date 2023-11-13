output "instance_group_url" {
  value = google_compute_instance_group_manager.appserver.instance_group
}

# output "named_port" {
#   value = google_compute_instance_group_manager.appserver.named_port
# }