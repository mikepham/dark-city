#!/bin/bash

if [ $# -eq 0 ]; then
  echo "No arguments supplied"
  exit
fi

echo "#" > ./env_$1/README.md

echo "## Environment: $1" >> ./env_$1/README.md
terraform-docs markdown environment >> ./env_$1/README.md

echo "## Module: certificates" >> ./env_$1/README.md
terraform-docs markdown modules/certificates >> ./env_$1/README.md

echo "## Module: rancher" >> ./env_$1/README.md
terraform-docs markdown modules/rancher >> ./env_$1/README.md

echo "## Module: rancher-aws" >> ./env_$1/README.md
terraform-docs markdown modules/secrets >> ./env_$1/README.md
