#!/bin/bash

echo "#" > ./MODULES.md

echo "## Module: environment" >> ./MODULES.md
terraform-docs markdown environment >> ./MODULES.md

echo "## Module: certificates" >> ./MODULES.md
terraform-docs markdown modules/certificates >> ./MODULES.md

echo "## Module: rancher" >> ./MODULES.md
terraform-docs markdown modules/rancher >> ./MODULES.md

echo "## Module: rancher-aws" >> ./MODULES.md
terraform-docs markdown modules/secrets >> ./MODULES.md
