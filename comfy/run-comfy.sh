#!/bin/bash
set -e

DROPLET_TPL="nvidia-h100"
DROPLET_NAME="comfy"
CLOUD_CONFIG="comfy"
IDENTITY_FILE="${DIGITALOCEAN_IDENTITY_FILE:-$HOME/.ssh/id_rsa}"
CONFIG_INIT_LOG="/var/log/cloud-init-output.log"

# Source the common functions
source ./common.sh

# Activate the Python virtual environment
source ../.env/bin/activate

# Create the droplet
dom droplet create $DROPLET_TPL $DROPLET_NAME --cloud-config $CLOUD_CONFIG

# Droplet info + Connect to the droplet and show the logs
show_droplet_info
show_droplet_logs