resource "google_monitoring_notification_channel" "default" {
  display_name = "Notification Email for Autoscaler"
  type         = "email"
  labels = {
    email_address = "lemanh2001.mnl@gmail.com"
  }
}
resource "google_monitoring_alert_policy" "alert-policy"{
    display_name = "Autoscaler UP and DOWN Alerting"
    combiner = "OR"
    conditions {
        display_name = "AUTOSCALER UP AND DOWN ALERTING"
        condition_threshold {
            filter    = "resource.type = \"instance_group\" AND metric.type = \"compute.googleapis.com/instance_group/size\""
            duration = "60s"
            comparison = "COMPARISON_GT"
            aggregations {
                alignment_period = "60s"
                cross_series_reducer = "REDUCE_NONE"
                per_series_aligner = "ALIGN_MEAN"
            }
            trigger {
                count = 1
            }
            threshold_value = 2
        }
    }
    notification_channels = [ google_monitoring_notification_channel.default.name]
 
}