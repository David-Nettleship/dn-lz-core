provider "aws" {
  region = "eu-west-2"
}

module "terraform_cicd_user" {
  source               = "../modules/iam/users/terraform-cicd"
  state_s3_bucket_name = "terraform-state-304707804854"
}
