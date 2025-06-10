# terraform-aws-lambda-multi-scheduler-stop-start

Terraform module that creates multiple AWS Lambda schedulers at once for stopping and starting AWS resources

## Usage

```hcl
module "terraform-aws-lambda-multi-scheduler-stop-start" {
  source = ""
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Tests

Some of these tests create real resources in an Azure subscription. That means they cost money to run, especially if you don't clean up after yourself. Please be considerate of the resources you create and take extra care to clean everything up when you're done!

In order to run tests that access your Azure subscription, run 'azure login'

### End-to-end tests

#### Terraform test

```shell
# Test basic terraform deployment
cd examples/simple
terraform test -verbose

# Test postgresql scheduler
cd examples/postgresql_scheduler
terraform test -verbose
```

## Authors

Modules managed by diodonfrost.

## Licence

Apache Software License 2.0.
