#!/bin/bash

# Exit Codes
#------------------------------------------------------------------------------
GO_BINARY_NOT_FOUND
GO_PATH_NOT_SET=2


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



# Install Terraform Go Plugins
#------------------------------------------------------------------------------
go get github.com/coreos/terraform-provider-ct
go get github.com/segmentio/terraform-docs
go get github.com/EvilSuperstars/terraform-provider-jsondecode
go get github.com/TimDurward/terraform-provider-slack
go get github.com/ashald/terraform-provider-yaml
