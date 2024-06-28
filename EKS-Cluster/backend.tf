terraform {
  backend "s3" {
    bucket = "my-assgnment-bucket"
    key    = "eks/terraform.tfstate"
    region = "ap-south-1"
  }
}
