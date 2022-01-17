variable "test-sn0-public" {}
variable "test-sn1-private" {}
variable "test-sg1-private" {}
variable "availability-zone-1a" {}

# Get AMIs from marketplace
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
