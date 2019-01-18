#!/bin/bash

REMOTE_HOST=master.nativecode.com
REMOTE_HOST_SSH_PORT=22
REMOTE_HOST_SSH_USER=core
REMOTE_HOST_TUNNEL_PORT=3389

# The local host is the destination of traffic received by the remote port
LOCAL_HOST=localhost
LOCAL_HOST_TUNNEL_PORT=3389

# Ignore early failed connections at boot
export AUTOSSH_GATETIME=0

autossh -4 -M 0 \
  -o ServerAliveInterval=60 \
  -o ExitOnForwardFailure=yes \
  -R 0.0.0.0:$REMOTE_HOST_TUNNEL_PORT:$LOCAL_HOST:$LOCAL_HOST_TUNNEL_PORT \
  -p $REMOTE_HOST_SSH_PORT \
  $REMOTE_HOST_SSH_USER@$REMOTE_HOST \
;
