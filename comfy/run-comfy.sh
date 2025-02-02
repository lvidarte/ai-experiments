#!/bin/bash
set -e

DROPLET_TYPE="gpu"
DROPLET_TPL="nvidia-h100"
DROPLET_NAME="comfy"
CLOUD_CONFIG="comfy"
IDENTITY_FILE="${DIGITALOCEAN_IDENTITY_FILE:-$HOME/.ssh/id_rsa}"
CONFIG_INIT_LOG="/var/log/cloud-init-output.log"

# Source the session functions
source ./session.sh

# Activate the Python virtual environment
source ../.env/bin/activate

# ------------------
# Create the droplet
# ------------------
# Export your SSH key ID to the environment variable DIGITALOCEAN_KEY_ID
# Use the command `dom key list` to get the ID.
PARAMS=""
if [[ -n "$DIGITALOCEAN_KEY_ID" ]]; then
    PARAMS="--key $DIGITALOCEAN_KEY_ID"
fi
dom droplet create $DROPLET_TPL $DROPLET_NAME --cloud-config $CLOUD_CONFIG $PARAMS #--dry-run
#exit 0

# Run the session:
# - Show droplet info
# - See the cloud-init logs (optional)
# - Connect to the droplet (optional)
# - Delete the droplet (optional)
run_session