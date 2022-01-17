# Rename default security group for test-default
resource "aws_default_security_group" "test-default" {
  vpc_id = aws_vpc.test.id

  #  ingress {
  #    protocol  = -1
  #    self      = true
  #    from_port = 0
  #    to_port   = 0
  #  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test-sg0-default"
  }
}

# Create security group for test private subnet
resource "aws_security_group" "test-sg1-private" {
  name        = "test-sg1-private"
  description = "test-sg1-private"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "Allow all traffic between test private subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${local.cidr_prefix.test}.1.0/24"]
  }

  ingress {
    description = "Allow all traffic from specific IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${local.myip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test-sg1-private"
  }
}
