**INFO**

In this repo you can find step-by-step insructions to create a Log aggregation/Monitoring mechanism against Kintsugi clients.
Terraform will be used to create a basic infrastructure on AWS, consisting of VPC, subnet(s), routes, security groups and finally an EC2 that will contain a dockerized version of Grafana, Prometheus, Promtail, Loki and Cadvisor.

**Technologies to be used**
- AWS
- Terraform
- Ansible
- docker

**What you need**
- A linux distro (preferably Ubuntu 20.04)
- An AWS account
- Terraform v1.1.3
- ansible [core 2.12.1]
- python 3.8.10

