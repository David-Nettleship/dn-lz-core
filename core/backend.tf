terraform {
  backend "s3" {
    bucket               = "terraform-state-304707804854"
    dynamodb_table       = "terraform-state-lock"
    key                  = "core/terraform.tfstate"
    region               = "eu-west-2"
  }
}