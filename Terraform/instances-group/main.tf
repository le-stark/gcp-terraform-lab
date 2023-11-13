resource "google_compute_autoscaler" "default" {
  name   = "autoscaler-manhlnd1-uscentral-dev-lab01"
  zone   = "us-central1-b"
  target = google_compute_instance_group_manager.appserver.id


  autoscaling_policy {
    max_replicas    = 4
    min_replicas    = 2
    cooldown_period = 60


    cpu_utilization {
      target = 0.8
    }

    load_balancing_utilization {
      target = 0.8
    }

  }

}

resource "google_compute_instance_group_manager" "appserver" {
  name = "instance-group-manhlnd1-uscentral-dev-lab01"

  base_instance_name = "nginx"
  zone               = "us-central1-b"

  version {
    instance_template = google_compute_region_instance_template.default.self_link
  }

  target_size = 2

  named_port {
    name = "loadbalancerhttp"
    port = 80
  }

  # auto_healing_policies {
  #   health_check      = google_compute_health_check.autohealing.id
  #   initial_delay_sec = 100
  # }
}


resource "google_compute_region_instance_template" "default" {
  name_prefix  = "it-manhlnd1-uscentral-dev-lab01-"
  machine_type = "e2-small"

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  # metadata_startup_script = <<-EOF
  #   sudo chmod 777 /var/www/html/index.html \
  #   echo "Hello world from $(hostname) $(hostname -I) with ManhLND1" > /var/www/html/index.html
  # EOF

  disk {
    source_image = var.source_image_name
    auto_delete  = true
    boot         = true
    // Backup the disk every day
    resource_policies = [google_compute_resource_policy.daily_backup.id]
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
  }
  // region = "us-central1" default will take the region comes from provider
}

resource "google_compute_resource_policy" "daily_backup" {
  name   = "backup-policy-manhlnd1-uscentral-dev-lab01"
  region = "us-central1"
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }
  }
}
