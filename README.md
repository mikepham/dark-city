# Dark City

## NativeCode Infrastructure

Deploys the following services:

### AWS

- Application Load Balancer
- Security Groups
- EFS Mounts
- ElasticSearch Domain

### Rancher

- Rancher Agent Launch Configuration
- Rancher Agent AutoScaling Group
- Rancher Maintenance Stacks
- Rancher NFS Stack
- Drone (only in production)

---

## Setup

### Requirements

- [Go](https://golang.org/dl])

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

- [Terraform](https://www.terraform.io/downloads.html)

### Configure AWS
```bash
aws configure
```

### Configure Go
```bash
mkdir ~/go
echo "PATH=~/go:$PATH" >> ~/.profile
```

### Install Plugins
```bash
go get github.com/coreos/terraform-provider-ct
go get github.com/TimDurward/terraform-provider-slack
go get github.com/EvilSuperstars/terraform-provider-jsondecode
go get github.com/ashald/terraform-provider-yaml
```

### Run Environment Script
```bash
deploy-dev

deploy-int

deploy-prod
```
