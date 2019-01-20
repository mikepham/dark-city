# Dark City

![dark-city](dark-city.jpg)

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

- [jq](https://stedolan.github.io/jq/download)

- [Go](https://golang.org/dl])

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

- [Terraform](https://www.terraform.io/downloads.html)

## Automatic Setup

You can use the `deploy` script, which can make sure you have the proper environment configured.

### First, we need to run the plugin and validation just once.

```bash
./deploy --env-plugins --env-validate
```

### Next, we can run the deploy with the target and environment and initialize terraform.

```bash
./deploy rancher -e dev -i
```
or
```bash
./deploy rancher -e dev --init
```

### Finally, you can repeatedly run the `deploy` unless you have made changes to your providers, in which case you must run the initialize again.

```bash
./deploy rancher -e dev
```
or
```bash
./deploy rancher --environment dev
```

### When you are ready to apply the deployment plan, simply run the apply.

```bash
./deploy rancher -e dev -a
```
or
```bash
./deploy rancher -e dev --apply
```

|Tips and Tricks|
|---|
|`./deploy rancher -e dev`|

## Manual Setup

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
go get github.com/segmentio/terraform-docs
go get github.com/EvilSuperstars/terraform-provider-jsondecode
go get github.com/TimDurward/terraform-provider-slack
go get github.com/ashald/terraform-provider-yaml
go get github.com/elliottsam/terraform-provider-windows-dns
go get github.com/elliottsam/winrm-dns-client
```

### Run Environment Script
```bash
deploy-dev

deploy-int

deploy-prod
```

## Notes

### Unverified

- Using multiple VPCs has not been tested.

### Not Working

- Agents do not unregistered with Rancher
- Agents do not properly join/unjoin an etcd cluster
