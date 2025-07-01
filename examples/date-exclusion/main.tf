resource "random_pet" "suffix" {}

module "date_exclusion" {
  source = "../.."

  schedulers = {
    aws-resources-stop = {
      name                         = "stop-at-night-${random_pet.suffix.id}"
      schedule_action              = "stop"
      schedule_expression          = "cron(0 22 ? * MON-FRI *)" # UTC+00:00
      schedule_expression_timezone = "UTC"
      autoscaling_schedule         = true
      ec2_schedule                 = true
      ecs_schedule                 = true
      rds_schedule                 = true
      redshift_schedule            = true
      documentdb_schedule          = true
      cloudwatch_alarm_schedule    = true
      transfer_schedule            = true
      scheduler_tag = {
        "key"   = "tostop"
        "value" = "true"
      }
    }
    aws-resources-start = {
      name                         = "start-at-morning-${random_pet.suffix.id}"
      schedule_action              = "start"
      schedule_expression          = "cron(0 6 ? * MON-FRI *)" # UTC+00:00
      schedule_expression_timezone = "UTC"
      scheduler_excluded_dates = [
        "01-01", # New Year's Day
        "12-25", # Christmas Day
        "12-24", # Christmas Eve
        "07-04", # Independence Day (US)
        "11-24", # Thanksgiving
        "05-01", # Labor Day
        "12-31", # New Year's Eve
      ]
      autoscaling_schedule      = true
      ec2_schedule              = true
      ecs_schedule              = true
      rds_schedule              = true
      redshift_schedule         = true
      documentdb_schedule       = true
      cloudwatch_alarm_schedule = true
      transfer_schedule         = true
      scheduler_tag = {
        "key"   = "tostop"
        "value" = "true"
      }
    }
  }
}
