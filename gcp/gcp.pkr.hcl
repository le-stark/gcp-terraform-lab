source "googlecompute" "ubuntu" {
  project_id   = var.project_id
  image_name = var.image_name
  source_image_family = var.image_family
  ssh_username = var.ssh_username
  zone         = var.zone
}