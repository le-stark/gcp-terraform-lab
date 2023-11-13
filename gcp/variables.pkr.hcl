variable project_id {
  type        = string
  description = "project_id from GCP account"
}

variable zone {
  type = string
  validation {
    condition     = length(var.zone) > 4 && substr(var.zone, 0, 3) == "us-"
    error_message = "The zone value must be a valid zone, starting with \"us-\"."
  }
}
variable ssh_username {
  type = string
}
variable image_family {
  type = string
}

variable image_name {
  type = string
}
