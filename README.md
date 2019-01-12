# Dark City

## NativeCode Infrastructure

### Setup

#### Requirements

- [Go](https://golang.org/dl])
- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

#### Configure AWS
```bash
aws configure
```

#### Configure Go
```bash
mkdir ~/go
echo "PATH=~/go:$PATH" >> ~/.profile
```

#### Install Plugins
```bash
go get github.com/coreos/terraform-provider-ct
go get github.com/TimDurward/terraform-provider-slack
go get github.com/EvilSuperstars/terraform-provider-jsondecode
go get github.com/ashald/terraform-provider-yaml
```

#### Run Environment Script
```bash
deploy-dev
deploy-int
deploy-prod
```
