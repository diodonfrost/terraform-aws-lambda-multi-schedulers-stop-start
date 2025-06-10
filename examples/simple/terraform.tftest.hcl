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
    condition     = contains(keys(module.multi_schedulers.scheduler_lambda_arn), "aws-resources-stop")
    error_message = "Should contain 'aws-stop' scheduler"
  }

  assert {
    condition     = contains(keys(module.multi_schedulers.scheduler_lambda_arn), "aws-resources-start")
    error_message = "Should contain 'aws-start' scheduler"
  }

  assert {
    condition     = can(regex("stop-at-night-", module.multi_schedulers.scheduler_lambda_name["aws-resources-stop"]))
    error_message = "Stop scheduler lambda name should contain 'stop-resources-at-night-'"
  }

  assert {
    condition     = can(regex("start-at-morning-", module.multi_schedulers.scheduler_lambda_name["aws-resources-start"]))
    error_message = "Start scheduler lambda name should contain 'start-at-morning-'"
  }

  assert {
    condition     = length(keys(module.multi_schedulers.scheduler_log_group_arn)) > 0
    error_message = "CloudWatch log groups should be created"
  }

  assert {
    condition     = module.multi_schedulers.scheduler_expression["aws-resources-stop"] == "cron(0 22 ? * MON-FRI *)"
    error_message = "Stop scheduler should have correct cron expression"
  }

  assert {
    condition     = module.multi_schedulers.scheduler_expression["aws-resources-start"] == "cron(0 6 ? * MON-FRI *)"
    error_message = "Start scheduler should have correct cron expression"
  }

  assert {
    condition     = module.multi_schedulers.scheduler_timezone["aws-resources-stop"] == "UTC"
    error_message = "Stop scheduler should have UTC timezone"
  }

  assert {
    condition     = module.multi_schedulers.scheduler_timezone["aws-resources-start"] == "UTC"
    error_message = "Start scheduler should have UTC timezone"
  }
}
