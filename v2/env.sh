#!/bin/bash

set -e

#------------------------------------------------------------------------------
# Export Environment Variables
#------------------------------------------------------------------------------
export DARKCITY_VERSION_MAJOR=0
export DARKCITY_VERSION_MINOR=1
export DARKCITY_VERSION="v$DARKCITY_VERSION_MAJOR.$DARKCITY_VERSION_MINOR"

if [ "$GOPATH" = "" ]; then
  mkdir -p ~/.local/go
  export GOPATH=~/.local/go
  export PATH=$GOPATH/bin:$PATH
fi


#------------------------------------------------------------------------------
# Banner
#------------------------------------------------------------------------------
echo "Dark City $DARKCITY_VERSION"
echo "Branch: `git branch | grep \* | cut -d ' ' -f2`"
echo "------------------------------------------------------------------------"


#------------------------------------------------------------------------------
# Argument Parsing
#------------------------------------------------------------------------------
POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    --clean)
      CLEAN=true
      shift
    ;;

    --plugins)
      PLUGINS=true
      shift
    ;;

    --validation)
      VALIDATION=true
      shift
    ;;

    *)
      ENVIRONMENT="$1"
      POSITIONAL+=("$1")
      shift
    ;;
  esac
done
set -- "${POSITIONAL[@]}"

CLEAN=${CLEAN:-false}
PLUGINS=${PLUGINS:-false}
VALIDATION=${VALIDATION:-false}


#------------------------------------------------------------------------------
# Exit Codes
#------------------------------------------------------------------------------
GO_BINARY_NOT_FOUND=100
JQ_BINARY_NOT_FOUND=101
TERRAFORM_BINARY_NOT_FOUND=102
TERRAFORM_DOCS_BINARY_NOT_FOUND=103
GO_PATH_NOT_SET=200


#------------------------------------------------------------------------------
# Clean the fast way!
#------------------------------------------------------------------------------
function clean() {
  echo "Cleaning folders"
  echo "------------------------------------------------------------------------"
  find . -name ".terraform" -type d -exec rm -r {} +
}

if [ "$CLEAN" = "true" ]; then
  clean
fi


#------------------------------------------------------------------------------
# Validation
#------------------------------------------------------------------------------
function validate() {
  echo "Validating Development Environment"
  echo "------------------------------------------------------------------------"

  #------------------------------------------------------------------------------
  # Validate Go Installation
  #------------------------------------------------------------------------------
  export GO=`which go`
  if [ "$GO" = "" ]; then
    echo "Go was not found. Have you installed Go?"
    exit $GO_BINARY_NOT_FOUND
  fi

  #------------------------------------------------------------------------------
  # Validating JQ Installation
  #------------------------------------------------------------------------------
  export JQ=`which jq`
  if [ "$JQ" = "" ]; then
    echo "JQ was not found. Have you installed JQ?"
    exit $JQ_BINARY_NOT_FOUND
  fi

  #------------------------------------------------------------------------------
  # Validate Terraform Installation
  #------------------------------------------------------------------------------
  export TERRAFORM=`which terraform`
  if [ "$TERRAFORM" = "" ]; then
    echo "Terrform was not found. Have you installed Terraform?"
    exit $TERRAFORM_BINARY_NOT_FOUND
  fi

  #------------------------------------------------------------------------------
  # Validate Terraform Docs Installation
  #------------------------------------------------------------------------------
  export TERRAFORM_DOCS="$GOPATH/bin/terraform-docs"
  if [ ! -f "$TERRAFORM_DOCS" ]; then
    echo "Terrform-Docs was not found. Did you install the plugins?"
    exit $TERRAFORM_DOCS_BINARY_NOT_FOUND
  fi
}

if [ "$VALIDATION" = "true" ]; then
  validate
fi


#------------------------------------------------------------------------------
# Install Terraform Go Plugins
#------------------------------------------------------------------------------
function plugins() {
  echo $GO
  echo $JQ
  echo $TERRAFORM
  echo "------------------------------------------------------------------------"
  echo $GOPATH
  echo "------------------------------------------------------------------------"

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
}

if [ "$PLUGINS" = "false" ]; then

  if [ "$VALIDATION" = "false" ]; then
    validate
  fi

  plugins

fi
