terraform {
  backend "s3" {
    bucket = "gbj-bee-980"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
    workspace_key_prefix = "env"
  }
}