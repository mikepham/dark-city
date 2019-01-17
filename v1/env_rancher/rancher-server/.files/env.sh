#!/bin/bash

set -e

if [ "$1" = "get_current_username" ]; then
  jq -n --arg user "$USER" '{ "username": $user }'
fi

if [ "$1" = "update_ssh_pem" ]; then
  chmod 0600 "$2"
  jq -n '{}'
fi

exit
