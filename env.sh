#!/bin/bash

set -e

#------------------------------------------------------------------------------
# Export Environment Variables
#------------------------------------------------------------------------------
export DARKCITY_VERSION_MAJOR=0
export DARKCITY_VERSION_MINOR=2
export DARKCITY_VERSION="v$DARKCITY_VERSION_MAJOR.$DARKCITY_VERSION_MINOR"

if [ "$GOPATH" = "" ]; then
    mkdir -p ~/.local/go
    export GOPATH=~/.local/go
    export PATH=$GOPATH/bin:$PATH
fi


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
        
        --no-banner)
            SHOW_BANNER=false
            shift
        ;;
        
        --silent)
            OUTPUT=true
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
OUTPUT=${OUTPUT:-false}
PLUGINS=${PLUGINS:-false}
SHOW_BANNER=${SHOW_BANNER:-true}
VALIDATION=${VALIDATION:-true}

#------------------------------------------------------------------------------
# Banner
#------------------------------------------------------------------------------
if [ "$SHOW_BANNER" = "true" ]; then
    echo "========================================================================"
    echo "Dark City $DARKCITY_VERSION © `date +'%Y'` NativeCode Development"
    echo "========================================================================"
    echo "Branch: `git branch | grep \* | cut -d ' ' -f2`"
    echo "------------------------------------------------------------------------"
    echo "ENV_CLEAN=$CLEAN"
    echo "ENV_PLUGINS=$PLUGINS"
    echo "ENV_VALIDATION=$VALIDATION"
    echo "------------------------------------------------------------------------"
fi

if [ "$OUTPUT" = "false" ]; then
    stty -echo
fi


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
function do_clean() {
    echo "Cleaning folders"
    echo "========================================================================"
    find . -name ".terraform" -type d -exec rm -r {} +
    find . -name ".tfstate" -type d -exec rm -r {} +
}

if [ "$CLEAN" = "true" ]; then
    do_clean
fi


#------------------------------------------------------------------------------
# Validation
#------------------------------------------------------------------------------
function do_validate() {
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
    # Validate Terraform Docs
    #------------------------------------------------------------------------------
    export TERRAFORM_DOCS="$GOPATH/bin/terraform-docs"
}

if [ "$VALIDATION" = "true" ]; then
    do_validate
fi

#------------------------------------------------------------------------------
# Install Terraform Go Plugins
#------------------------------------------------------------------------------
function do_plugins() {
    echo $GO
    echo $JQ
    echo $TERRAFORM
    echo "------------------------------------------------------------------------"
    echo $GOPATH
    echo "------------------------------------------------------------------------"
    
    TERRAFORM_PLUGINS_PATH=$HOME/.terraform.d/plugins/linux_amd64
    
    if [ ! -d "$TERRAFORM_PLUGINS_PATH" ]; then
        mkdir "$TERRAFORM_PLUGINS_PATH" -p
    fi
    
    declare -A PLUGINS
    PLUGINS["terraform-provider-ct"]="github.com/coreos/terraform-provider-ct"
    PLUGINS["terraform-provider-jsondecode"]="github.com/EvilSuperstars/terraform-provider-jsondecode"
    PLUGINS["terraform-provider-slack"]="github.com/TimDurward/terraform-provider-slack"
    PLUGINS["terraform-provider-windns"]="github.com/portofportland/terraform-provider-windns"
    PLUGINS["terraform-provider-windows-dns"]="github.com/elliottsam/terraform-provider-windows-dns"
    PLUGINS["terraform-provider-yaml"]="github.com/ashald/terraform-provider-yaml"
    
    declare -A TOOLS
    TOOLS["terraform-docs"]="github.com/segmentio/terraform-docs"
    TOOLS["winrm-dns-client"]="github.com/elliottsam/winrm-dns-client"
    
    for plugin in "${!PLUGINS[@]}"; do
        if [ ! -f "$GOPATH/bin/$plugin" ]; then
            echo "Installing $plugin"
            go get "${PLUGINS[$plugin]}"
            
            # Create symink
            if [ ! -h "$TERRAFORM_PLUGINS_PATH/$plugin" ]; then
                ln -s "$GOPATH/bin/$plugin" "$TERRAFORM_PLUGINS_PATH/$plugin"
                echo "Created SymLink at $TERRAFORM_PLUGINS_PATH/$plugin"
            fi
        else
            echo "Skipping $plugin"
        fi
    done
    
    for tool in "${!TOOLS[@]}"; do
        if [ ! -f "$GOPATH/bin/$tool" ]; then
            echo "Installing $tool"
            go get "${TOOLS[$tool]}"
            echo "------------------------------------------------------------------------"
        else
            echo "Skipping $tool"
        fi
    done
    
    echo "========================================================================"
}

if [ "$PLUGINS" = "true" ]; then
    if [ "$VALIDATION" = "false" ]; then
        do_validate
    fi
    
    do_plugins
fi

if [ "$OUTPUT" = "false" ]; then
    stty echo
fi
