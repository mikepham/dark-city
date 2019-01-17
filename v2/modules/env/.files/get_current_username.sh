#!/bin/bash
set -e
jq -n --arg user "$USER" '{ "username": $user }'
