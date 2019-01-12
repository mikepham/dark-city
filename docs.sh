#!/bin/bash

if [ $# -eq 0 ]; then
  sh ./docs.sh development
  sh ./docs.sh internal
  sh ./docs.sh production
  exit
fi

echo "#" > ./env_$1/README.md

echo "## Environment: $1" >> ./env_$1/README.md
terraform-docs markdown environment >> ./env_$1/README.md

echo "## Module: certificates" >> ./modules/certificates/README.md
terraform-docs markdown modules/certificates >> ./modules/certificates/README.md

echo "## Module: rancher" >> ./modules/rancher/README.md
terraform-docs markdown modules/rancher >> ./modules/rancher/README.md

echo "## Module: secrets" >> ./modules/secrets/README.md
terraform-docs markdown modules/secrets >> ./modules/secrets/README.md
