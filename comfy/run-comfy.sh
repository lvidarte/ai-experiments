#!/bin/bash

DROPLET_TYPE="gpu"
DROPLET_TPL="nvidia-h100"
DROPLET_NAME="comfy"
CLOUD_CONFIG="comfy"

# Source the session functions
source ./session.sh

# Activate the Python virtual environment
source ../.env/bin/activate

# ------------------
# Create the droplet
# ------------------
dom droplet create $DROPLET_TPL $DROPLET_NAME \
    --key $DIGITALOCEAN_KEY_ID \
    --cloud-config $CLOUD_CONFIG #--dry-run; exit 0

# Run the session:
# - Show droplet info
# - See the cloud-init logs (optional)
# - Connect to the droplet (optional)
# - Delete the droplet (optional)
run_session