#!/bin/bash
set -e

DROPLET_TPL="cpu-mini"
DROPLET_NAME="downloader"
CLOUD_CONFIG="downloader"
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