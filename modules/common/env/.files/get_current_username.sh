#!/bin/bash
set -e
USERNAME=`id -u -n`
jq -n --arg user "$USERNAME" '{ "username": $user }'
