variable "region" {}
variable "environment" {}

locals { availability-zone-1a = "eu-central-1a" }
locals { myip = "xx.xx.xx.xx" }

locals {
  cidr_prefix = {
    test = "192.10"
  }
}

output "test-sn0-public" {
  value = aws_subnet.test-sn0-public
}

output "test-sn1-private" {
  value = aws_subnet.test-sn1-private
}

output "test-sg1-private" {
  value = aws_security_group.test-sg1-private
}

output "availability-zone-1a" {
  value = local.availability-zone-1a
}
