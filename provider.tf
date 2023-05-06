terraform {
  required_providers{
    aws = {
        source = "hashicorp/aws"
        version = var.provider_details.version
    }
  }
}
provider "aws"{
    region = var.provider_details.region
}