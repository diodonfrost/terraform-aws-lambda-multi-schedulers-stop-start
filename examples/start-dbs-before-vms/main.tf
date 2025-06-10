resource "random_pet" "suffix" {}

module "multi_schedulers" {
  source = "../.."

  schedulers = {
    start-databases = {
      name                         = "start-databases-${random_pet.suffix.id}"
      schedule_action              = "start"
      schedule_expression          = "cron(45 5 ? * MON-FRI *)" # 05:45 UTC - 15 minutes before VMs
      schedule_expression_timezone = "UTC"
      rds_schedule                 = true
      redshift_schedule            = true
      documentdb_schedule          = true
      scheduler_tag = {
        "key"   = "schedule"
        "value" = "database"
      }
    }
    start-vms = {
      name                         = "start-vms-${random_pet.suffix.id}"
      schedule_action              = "start"
      schedule_expression          = "cron(0 6 ? * MON-FRI *)" # 06:00 UTC - after databases
      schedule_expression_timezone = "UTC"
      ec2_schedule                 = true
      autoscaling_schedule         = true
      ecs_schedule                 = true
      scheduler_tag = {
        "key"   = "schedule"
        "value" = "compute"
      }
    }
    stop-vms = {
      name                         = "stop-vms-${random_pet.suffix.id}"
      schedule_action              = "stop"
      schedule_expression          = "cron(0 22 ? * MON-FRI *)" # 22:00 UTC - stop VMs first
      schedule_expression_timezone = "UTC"
      ec2_schedule                 = true
      autoscaling_schedule         = true
      ecs_schedule                 = true
      scheduler_tag = {
        "key"   = "schedule"
        "value" = "compute"
      }
    }
    stop-databases = {
      name                         = "stop-databases-${random_pet.suffix.id}"
      schedule_action              = "stop"
      schedule_expression          = "cron(15 22 ? * MON-FRI *)" # 22:15 UTC - 15 minutes after VMs
      schedule_expression_timezone = "UTC"
      rds_schedule                 = true
      redshift_schedule            = true
      documentdb_schedule          = true
      scheduler_tag = {
        "key"   = "schedule"
        "value" = "database"
      }
    }
  }
}