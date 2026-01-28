data "aws_region" "current" {}

module "scheduler" {
  for_each = var.schedulers
  source   = "diodonfrost/lambda-scheduler-stop-start/aws"
  version  = "4.4.0"

  name                            = each.value.name
  schedule_expression             = each.value.schedule_expression
  schedule_expression_timezone    = each.value.schedule_expression_timezone
  scheduler_excluded_dates        = each.value.scheduler_excluded_dates
  custom_iam_role_arn             = each.value.custom_iam_role_arn
  kms_key_arn                     = each.value.kms_key_arn
  aws_regions                     = each.value.aws_regions == null ? [data.aws_region.current.name] : each.value.aws_regions
  runtime                         = each.value.runtime
  schedule_action                 = each.value.schedule_action
  resources_tag                   = each.value.resources_tag
  scheduler_tag                   = each.value.scheduler_tag
  autoscaling_schedule            = each.value.autoscaling_schedule
  autoscaling_terminate_instances = each.value.autoscaling_terminate_instances
  ec2_schedule                    = each.value.ec2_schedule
  documentdb_schedule             = each.value.documentdb_schedule
  ecs_schedule                    = each.value.ecs_schedule
  rds_schedule                    = each.value.rds_schedule
  redshift_schedule               = each.value.redshift_schedule
  cloudwatch_alarm_schedule       = each.value.cloudwatch_alarm_schedule
  transfer_schedule               = each.value.transfer_schedule
  apprunner_schedule              = each.value.apprunner_schedule
  tags                            = each.value.tags
}
