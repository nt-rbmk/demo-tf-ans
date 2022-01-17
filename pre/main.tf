variable "region" {
  default = "eu-central-1"
}
locals { environment = "nt-rbmk" }

provider "aws" {
  region  = var.region
  profile = local.environment
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "nt-rbmk-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

