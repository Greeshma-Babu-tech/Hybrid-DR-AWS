provider "aws" {
  region = var.region
}


module "network" {
  source = "./modules/network"
}

module "security" {
  source = "./modules/security"
}

module "iam" {
  source = "./modules/iam"
}

module "compute" {
  source = "./modules/compute"
}

module "database" {
  source = "./modules/database"
}

module "s3" {
  source = "./modules/s3"
}
