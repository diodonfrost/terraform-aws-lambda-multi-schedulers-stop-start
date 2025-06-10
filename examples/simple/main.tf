resource "random_pet" "suffix" {}

module "terraform-aws-lambda-multi-scheduler-stop-start" {
  source = "../.."
}
