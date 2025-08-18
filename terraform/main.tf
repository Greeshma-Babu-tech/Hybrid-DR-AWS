provider "aws" {
  region = var.region
}

/*#Setting backend 
terraform {
  backend "s3" {
    bucket         = "dr-terraform-backend-bucket"
    key            = "dr-terraform-state/hybrid-dr.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dr-terraform-lock-table"
    # use_lockfile   = true
  }
}*/

module "network" {
  source = "./modules/network"

}

module "security" {
  depends_on = [module.network]
  source     = "./modules/security"
  dr_vpc_id  = module.network.vpc_id

}

module "iam" {
  depends_on = [module.network]
  source     = "./modules/iam"
}

module "compute" {
  depends_on            = [module.network, module.security, module.iam]
  source                = "./modules/compute"
  public_subnet_id      = module.network.dr_subnet_public
  security_group_id     = module.security.dr_sg_id
  instance_profile_name = module.iam.ec2_profile_name
}

module "database" {
  depends_on          = [module.network]
  source              = "./modules/database"
  private_subnet_id_1 = module.network.dr_subnet_private_1
  private_subnet_id_2 = module.network.dr_subnet_private_2
}

module "s3" {
  source = "./modules/s3"
}
