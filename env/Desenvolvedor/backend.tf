terraform {
  backend "s3" {
    bucket = "ecsfernando"
    key    = "Dev/terraform.tfstate"
    region = "us-west-2"
  }
}