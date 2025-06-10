run "validate_creation" {
  command = apply

  assert {
    condition     = length(keys(module.multi_schedulers.lambda_iam_role_arn)) > 0
    error_message = "Lambda IAM role ARN should be created"
  }

  assert {
    condition     = length(keys(module.multi_schedulers.scheduler_lambda_arn)) > 0
    error_message = "Lambda functions should be created"
  }

  assert {
    condition     = contains(keys(module.multi_schedulers.scheduler_lambda_arn), "start-databases")
    error_message = "Should contain 'start-databases' scheduler"
  }

  assert {
    condition     = contains(keys(module.multi_schedulers.scheduler_lambda_arn), "start-vms")
    error_message = "Should contain 'start-vms' scheduler"
  }

  assert {
    condition     = contains(keys(module.multi_schedulers.scheduler_lambda_arn), "stop-vms")
    error_message = "Should contain 'stop-vms' scheduler"
  }

  assert {
    condition     = contains(keys(module.multi_schedulers.scheduler_lambda_arn), "stop-databases")
    error_message = "Should contain 'stop-databases' scheduler"
  }

  assert {
    condition     = can(regex("start-databases-", module.multi_schedulers.scheduler_lambda_name["start-databases"]))
    error_message = "Database start scheduler lambda name should contain 'start-databases-'"
  }

  assert {
    condition     = can(regex("start-vms-", module.multi_schedulers.scheduler_lambda_name["start-vms"]))
    error_message = "VM start scheduler lambda name should contain 'start-vms-'"
  }

  assert {
    condition     = length(keys(module.multi_schedulers.scheduler_log_group_arn)) > 0
    error_message = "CloudWatch log groups should be created"
  }

  assert {
    condition     = module.multi_schedulers.scheduler_expression["start-databases"] == "cron(45 5 ? * MON-FRI *)"
    error_message = "Database start scheduler should have correct cron expression (05:45 UTC)"
  }

  assert {
    condition     = module.multi_schedulers.scheduler_expression["start-vms"] == "cron(0 6 ? * MON-FRI *)"
    error_message = "VM start scheduler should have correct cron expression (06:00 UTC)"
  }

  assert {
    condition     = module.multi_schedulers.scheduler_expression["stop-vms"] == "cron(0 22 ? * MON-FRI *)"
    error_message = "VM stop scheduler should have correct cron expression (22:00 UTC)"
  }

  assert {
    condition     = module.multi_schedulers.scheduler_expression["stop-databases"] == "cron(15 22 ? * MON-FRI *)"
    error_message = "Database stop scheduler should have correct cron expression (22:15 UTC)"
  }

  assert {
    condition = alltrue([
      for scheduler_name in keys(module.multi_schedulers.scheduler_timezone) :
      module.multi_schedulers.scheduler_timezone[scheduler_name] == "UTC"
    ])
    error_message = "All schedulers should have UTC timezone"
  }
}