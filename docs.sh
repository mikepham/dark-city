#!/bin/bash

echo "#" > ./modules/README.md

echo "## Module: environment" >> ./modules/README.md
terraform-docs markdown environment >> ./modules/README.md

echo "## Module: certificates" >> ./modules/README.md
terraform-docs markdown modules/certificates >> ./modules/README.md

echo "## Module: rancher" >> ./modules/README.md
terraform-docs markdown modules/rancher >> ./modules/README.md

echo "## Module: rancher-aws" >> ./modules/README.md
terraform-docs markdown modules/secrets >> ./modules/README.md
