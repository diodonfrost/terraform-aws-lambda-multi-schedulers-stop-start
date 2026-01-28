# terraform-aws-lambda-multi-schedulers-stop-start

Terraform module that creates multiple AWS Lambda schedulers at once for stopping and starting AWS resources

This module is a wrapper around the [terraform-aws-lambda-scheduler-stop-start](https://github.com/diodonfrost/terraform-aws-lambda-scheduler-stop-start) module, allowing you to deploy multiple schedulers at once.

## Usage

```hcl
module "multi_schedulers" {
  source = "diodonfrost/lambda-multi-schedulers-stop-start/aws"
  version = "4.1.0"

  schedulers = {
    aws-resources-stop = {
      name                         = "stop-at-night"
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
      name                         = "start-at-morning"
      schedule_action              = "start"
      schedule_expression          = "cron(0 6 ? * MON-FRI *)" # UTC+00:00
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
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.29.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_scheduler"></a> [scheduler](#module\_scheduler) | diodonfrost/lambda-scheduler-stop-start/aws | 4.4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_schedulers"></a> [schedulers](#input\_schedulers) | A map of scheduler configurations | <pre>map(object({<br/>    name                         = string<br/>    schedule_expression          = optional(string, "cron(0 22 ? * MON-FRI *)")<br/>    schedule_expression_timezone = optional(string, "UTC")<br/>    scheduler_excluded_dates     = optional(list(string), [])<br/>    custom_iam_role_arn          = optional(string, null)<br/>    kms_key_arn                  = optional(string, null)<br/>    aws_regions                  = optional(list(string), null)<br/>    runtime                      = optional(string, "python3.13")<br/>    schedule_action              = optional(string, "stop")<br/>    resources_tag                = optional(map(string), null)<br/>    scheduler_tag = optional(map(string), {<br/>      "key"   = "tostop"<br/>      "value" = "true"<br/>    })<br/>    autoscaling_schedule            = optional(bool, false)<br/>    autoscaling_terminate_instances = optional(bool, false)<br/>    ec2_schedule                    = optional(bool, false)<br/>    documentdb_schedule             = optional(bool, false)<br/>    ecs_schedule                    = optional(bool, false)<br/>    rds_schedule                    = optional(bool, false)<br/>    redshift_schedule               = optional(bool, false)<br/>    cloudwatch_alarm_schedule       = optional(bool, false)<br/>    transfer_schedule               = optional(bool, false)<br/>    apprunner_schedule              = optional(bool, false)<br/>    tags                            = optional(map(any), null)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_iam_role_arn"></a> [lambda\_iam\_role\_arn](#output\_lambda\_iam\_role\_arn) | The ARN of the IAM role used by Lambda function for each scheduler |
| <a name="output_lambda_iam_role_name"></a> [lambda\_iam\_role\_name](#output\_lambda\_iam\_role\_name) | The name of the IAM role used by Lambda function for each scheduler |
| <a name="output_scheduler_expression"></a> [scheduler\_expression](#output\_scheduler\_expression) | The expression of the scheduler for each scheduler |
| <a name="output_scheduler_lambda_arn"></a> [scheduler\_lambda\_arn](#output\_scheduler\_lambda\_arn) | The ARN of the Lambda function for each scheduler |
| <a name="output_scheduler_lambda_function_last_modified"></a> [scheduler\_lambda\_function\_last\_modified](#output\_scheduler\_lambda\_function\_last\_modified) | The date Lambda function was last modified for each scheduler |
| <a name="output_scheduler_lambda_function_version"></a> [scheduler\_lambda\_function\_version](#output\_scheduler\_lambda\_function\_version) | Latest published version of your Lambda function for each scheduler |
| <a name="output_scheduler_lambda_invoke_arn"></a> [scheduler\_lambda\_invoke\_arn](#output\_scheduler\_lambda\_invoke\_arn) | The ARN to be used for invoking Lambda function from API Gateway for each scheduler |
| <a name="output_scheduler_lambda_name"></a> [scheduler\_lambda\_name](#output\_scheduler\_lambda\_name) | The name of the Lambda function for each scheduler |
| <a name="output_scheduler_log_group_arn"></a> [scheduler\_log\_group\_arn](#output\_scheduler\_log\_group\_arn) | The Amazon Resource Name (ARN) specifying the log group for each scheduler |
| <a name="output_scheduler_log_group_name"></a> [scheduler\_log\_group\_name](#output\_scheduler\_log\_group\_name) | The name of the scheduler log group for each scheduler |
| <a name="output_scheduler_timezone"></a> [scheduler\_timezone](#output\_scheduler\_timezone) | The timezone of the scheduler for each scheduler |
<!-- END_TF_DOCS -->

## Tests

Some of these tests create real resources in an AWS account. That means they cost money to run, especially if you don't clean up after yourself. Please be considerate of the resources you create and take extra care to clean everything up when you're done!

In order to run tests that access your AWS account, ensure you have valid AWS credentials configured (via AWS CLI, environment variables, or IAM roles)

### End-to-end tests

#### Terraform test

```shell
# Test basic terraform deployment
cd examples/simple
terraform test -verbose
```

## Authors

Modules managed by diodonfrost.

## Licence

Apache Software License 2.0.
