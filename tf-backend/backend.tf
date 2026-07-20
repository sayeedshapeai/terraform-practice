terraform {


 backend "s3" {
    region = "us-east-1"


 bucket = "sayeed-terraform-state-2026"


 key = "project/dev/terraform.tfstate"

 dynamodb_table = "terraform-lock"


 encrypt = true


 }


}
