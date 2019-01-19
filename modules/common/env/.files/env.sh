#!/bin/bash
set -e
jq -n \
--arg home "$HOME" \
--arg hostname "$HOSTNAME" \
--arg path "$PATH" \
--arg username "${USERNAME:-$USER}" '{
  "home": $home,
  "hostname": $hostname,
  "path": $path,
  "username": $username
}'
