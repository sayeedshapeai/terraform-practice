terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<6.54.0"
      #version = ">6.54.0"
      #version = > 5.0.0, <6.0.0 #example of provider version constraints
    }

  }
}
