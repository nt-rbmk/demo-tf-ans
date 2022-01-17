terraform {
  backend "s3" {
    region  = "eu-central-1"
    profile = "nt-rbmk"
    bucket  = "nt-rbmk-terraform-state"
    key     = "terraform.tfstate"
    encrypt = "true"
  }
}

module "vpc" {
  source      = "./modules/vpc"
  region      = var.region
  environment = local.environment
}

module "ec2s" {
  source               = "./modules/ec2s"
  availability-zone-1a = module.vpc.availability-zone-1a
  test-sn0-public      = module.vpc.test-sn0-public
  test-sn1-private     = module.vpc.test-sn1-private
  test-sg1-private     = module.vpc.test-sg1-private
}
