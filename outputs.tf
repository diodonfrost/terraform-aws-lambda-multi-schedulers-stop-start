output "lambda_iam_role_arn" {
  description = "The ARN of the IAM role used by Lambda function for each scheduler"
  value       = { for k, v in module.scheduler : k => v.lambda_iam_role_arn }
}

output "lambda_iam_role_name" {
  description = "The name of the IAM role used by Lambda function for each scheduler"
  value       = { for k, v in module.scheduler : k => v.lambda_iam_role_name }
}

output "scheduler_lambda_arn" {
  description = "The ARN of the Lambda function for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_lambda_arn }
}

output "scheduler_lambda_name" {
  description = "The name of the Lambda function for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_lambda_name }
}

output "scheduler_lambda_invoke_arn" {
  description = "The ARN to be used for invoking Lambda function from API Gateway for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_lambda_invoke_arn }
}

output "scheduler_lambda_function_last_modified" {
  description = "The date Lambda function was last modified for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_lambda_function_last_modified }
}

output "scheduler_lambda_function_version" {
  description = "Latest published version of your Lambda function for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_lambda_function_version }
}

output "scheduler_log_group_name" {
  description = "The name of the scheduler log group for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_log_group_name }
}

output "scheduler_log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_log_group_arn }
}

output "scheduler_expression" {
  description = "The expression of the scheduler for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_expression }
}

output "scheduler_timezone" {
  description = "The timezone of the scheduler for each scheduler"
  value       = { for k, v in module.scheduler : k => v.scheduler_timezone }
}
