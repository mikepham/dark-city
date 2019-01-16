#!/bin/bash

# Clean the fast way!
#------------------------------------------------------------------------------
git stash
rm -rf 
git stash pop


# Exit Codes
#------------------------------------------------------------------------------
GO_BINARY_NOT_FOUND=1
GO_PATH_NOT_SET=2
TERRAFORM_BINARY_NOT_FOUND=3

echo "Validating Development Environment"
echo "------------------------------------------------------------------------"


# Validate Go Installation
#------------------------------------------------------------------------------
GO=`which go`
GO_PATH=${GOPATH:-""}

if [ "$GO" = "" ]; then
  echo "Go was not found. Have you installed Go?"
  exit $GO_BINARY_NOT_FOUND
fi

if [ "$GO_PATH" = "" ]; then
  echo "GOPATH was not set."
  echo "Make sure Go is installed and that the GOPATH is set."
  exit $GO_PATH_NOT_SET
fi


# Validate Terraform Installation
#------------------------------------------------------------------------------
TERRAFORM=`which terraform`

if [ "$TERRAFORM" = "" ]; then
  echo "Terrform was not found. Have you installed Terraform?"
  exit $TERRAFORM_BINARY_NOT_FOUND
fi


# Informational
#------------------------------------------------------------------------------
echo "GO: $GO"
echo "GOPATH: $GO_PATH"
echo "TERRAFORM: $TERRAFORM"
echo "------------------------------------------------------------------------"


# Install Terraform Go Plugins
#------------------------------------------------------------------------------
if [ ! -f "$GOPATH/bin/terraform-docs" ]; then
  echo "Installing Terraform Docs"
  go get github.com/segmentio/terraform-docs
  echo "------------------------------------------------------------------------"
fi

if [ ! -f "$GOPATH/bin/terraform-provider-ct" ]; then
  echo "Installing Terraform Config Transform (CoreOS)"
  go get github.com/coreos/terraform-provider-ct
  echo "------------------------------------------------------------------------"
fi

if [ ! -f "$GOPATH/bin/terraform-provider-jsondecode" ]; then
  echo "Installing Terraform JSON Decode"
  go get github.com/EvilSuperstars/terraform-provider-jsondecode
  echo "------------------------------------------------------------------------"
fi

if [ ! -f "$GOPATH/bin/terraform-provider-slack" ]; then
  echo "Installing Terraform Slack"
  go get github.com/TimDurward/terraform-provider-slack
  echo "------------------------------------------------------------------------"
fi

if [ ! -f "$GOPATH/bin/terraform-provider-yaml" ]; then
  echo "Installing Terraform Yaml"
  go get github.com/ashald/terraform-provider-yaml
  echo "------------------------------------------------------------------------"
fi
