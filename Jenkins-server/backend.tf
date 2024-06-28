terraform {
  backend "s3" {
    bucket = "my-assgnment-bucket"
    key    = "jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}
