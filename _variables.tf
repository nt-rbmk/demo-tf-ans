variable "region" {
  default = "eu-central-1"
}
locals { environment = "nt-rbmk" }

provider "aws" {
  region  = var.region
  profile = local.environment
}

output "environment" { value = local.environment }
