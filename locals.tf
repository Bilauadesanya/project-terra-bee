locals {
  project_tags = {

    contact = "dev@acc.com"
    project = "Tiktok"
    application = "payments"
    environment = "${terraform.workspace}"
    creationTime = timestamp()
  }
}