terraform {
  backend "s3" {
    bucket = "terraform-state-test-0001"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}