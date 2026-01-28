variable "schedulers" {
  description = "A map of scheduler configurations"
  type = map(object({
    name                         = string
    schedule_expression          = optional(string, "cron(0 22 ? * MON-FRI *)")
    schedule_expression_timezone = optional(string, "UTC")
    scheduler_excluded_dates     = optional(list(string), [])
    custom_iam_role_arn          = optional(string, null)
    kms_key_arn                  = optional(string, null)
    aws_regions                  = optional(list(string), null)
    runtime                      = optional(string, "python3.13")
    schedule_action              = optional(string, "stop")
    resources_tag                = optional(map(string), null)
    scheduler_tag = optional(map(string), {
      "key"   = "tostop"
      "value" = "true"
    })
    autoscaling_schedule            = optional(bool, false)
    autoscaling_terminate_instances = optional(bool, false)
    ec2_schedule                    = optional(bool, false)
    documentdb_schedule             = optional(bool, false)
    ecs_schedule                    = optional(bool, false)
    rds_schedule                    = optional(bool, false)
    redshift_schedule               = optional(bool, false)
    cloudwatch_alarm_schedule       = optional(bool, false)
    transfer_schedule               = optional(bool, false)
    apprunner_schedule              = optional(bool, false)
    tags                            = optional(map(any), null)
  }))
  default = {}
}
