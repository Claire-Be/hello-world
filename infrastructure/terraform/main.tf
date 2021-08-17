provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Manager = "Terraform"
      Creator = "Claire B"
    }
  }
}