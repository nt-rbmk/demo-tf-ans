# Create a new EC2 using Ubuntu AMI
resource "aws_instance" "demo" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3a.medium" # $0.0432/h
  subnet_id                   = var.test-sn0-public.id
  availability_zone           = var.availability-zone-1a
  vpc_security_group_ids      = [var.test-sg1-private.id]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = "16"
  }

  key_name = "foo"

  tags = {
    Name = "demo"
  }

  volume_tags = {
    Name = "demo"
  }

  lifecycle {
    ignore_changes = [ami]
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'",
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/nt-rbmk/.ssh/foo.pem")
      timeout     = "2m"
    }
  }

  provisioner "local-exec" {
    command = "echo 'add ${self.public_ip} into ansible inventory' ; sleep 60 ; ansible-playbook -u ubuntu --private-key /home/nt-rbmk/.ssh/foo.pem ansible/playbooks/demo.yaml --limit ${self.public_ip}"
  }
}
