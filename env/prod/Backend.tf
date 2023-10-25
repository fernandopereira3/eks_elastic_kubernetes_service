terraform {
  backend "s3" {
    bucket = "ecsfernando"
    key    = "Prod/terraform.tfstate"
    region = "us-west-2"
  }
}