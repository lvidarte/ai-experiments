#!/bin/bash
set -e

DROPLET_TPL="nvidia-h100"
DROPLET_NAME="comfy"
CLOUD_CONFIG="comfy"

source ../.ai_env/bin/activate
dom droplet create $DROPLET_TPL $DROPLET_NAME --cloud-config $CLOUD_CONFIG
dom droplet list
deactivate