provider "aws" {
  access_key = var.AWS_ACCESS_KEY #alternatively store it in the local using aws configure.
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}

