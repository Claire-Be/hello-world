provider "aws" {
  region = var.region
  default_tags = {
    Manager = "Terraform",
    Creator = "Claire B"
  }
}