#!/bin/bash
set -e

DROPLET_TPL="nvidia-h100"
DROPLET_NAME="comfy"
CLOUD_CONFIG="comfy"

source ../.ai_env/bin/activate

dom droplet create $DROPLET_TPL $DROPLET_NAME --cloud-config $CLOUD_CONFIG

IP=$(dom droplet list --droplet-type gpu | grep $DROPLET_NAME | grep -oP 'PublicIP: \K[\d.]+')
if [ -z "$IP" ]; then
    echo "Failed to get IP address for the new droplet."
    exit 1
else
    dom droplet list --droplet-type gpu | grep $DROPLET_NAME
    echo "Droplet already created."
    echo "Try Comfy at http://$IP:5000 (it may take a few minutes to start)."
fi

deactivate