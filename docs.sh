#!/bin/bash

echo "#" > README.md

echo "## Module: main" >> README.md
terraform-docs markdown . >> README.md

echo "## Module: rancher" >> README.md
terraform-docs markdown rancher >> README.md

echo "## Module: rancher-aws" >> README.md
terraform-docs markdown rancher-aws >> README.md
