terraform {
  backend "s3" {
    bucket = "terraform-s3-bucketss"
    key    = "terraform.tfstate"
    region = "us-east-1"
  use_lockfile = true
  }
}
 