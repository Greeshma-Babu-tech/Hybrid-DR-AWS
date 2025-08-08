
#Setting backend 
terraform {
  backend "s3" {
    bucket         = "dr-terraform-backend-bucket"
    key            = "dr-terraform-state/hybrid-dr.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dr-terraform-lock-table"
    # use_lockfile   = true
  }
}
