#!/bin/bash

# Copyright 2025 Cloutfit.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ================================================
# ALERT: Don't run this file directly.
# Use this file by sourcing it in your run script.
# ================================================

DROPLET_ID=""
DROPLET_IP=""
SSH_CMD=""
CONFIG_INIT_LOG="/var/log/cloud-init-output.log"


# Check if the required environment variables are set
if [ -z "$DIGITALOCEAN_TOKEN" ]; then
    echo "DIGITALOCEAN_TOKEN is not set."
    exit 1
fi

if [ -z "$DIGITALOCEAN_KEY_ID" ]; then
    echo "DIGITALOCEAN_KEY_ID is not set."
    exit 1
fi

if [ -z "$DIGITALOCEAN_IDENTITY_FILE" ]; then
    echo "DIGITALOCEAN_IDENTITY_FILE is not set."
    exit 1
fi


# Echo a separator line
function echo_separator() {
    echo "----------------------------------------------------------------"
}

# Get the IP address of the new droplet
function get_droplet_id() {
    if [ "$DROPLET_ID" == "" ]; then
        DROPLET_ID=$(dom droplet list --droplet-type $DROPLET_TYPE | grep $DROPLET_NAME | sed -n 's/^ID: \([^,]*\).*/\1/p')
    fi

    if [ "$DROPLET_ID" == "" ]; then
        echo "Failed to get the droplet ID."
        exit 1
    fi
    
    echo "$DROPLET_ID"
}

# Get the IP address of the new droplet
function get_droplet_ip() {
    if [ "$DROPLET_IP" == "" ]; then
        DROPLET_IP=$(dom droplet list --droplet-type $DROPLET_TYPE | grep $DROPLET_NAME | sed -n 's/.*PublicIP: \([^,]*\).*/\1/p')
    fi

    if [[ -z "$DROPLET_IP" || "$DROPLET_IP" == "None" ]]; then
        echo "Failed to get droplet IP address."
        exit 1
    fi
    
    echo "$DROPLET_IP"
}

# Get the SSH command to connect to the new droplet
function get_ssh_cmd() {
    if [ "$SSH_CMD" == "" ]; then
        local droplet_ip=$(get_droplet_ip)
        SSH_CMD="ssh -i $DIGITALOCEAN_IDENTITY_FILE root@$droplet_ip"
    fi

    echo "$SSH_CMD"
}

# Show the information about the new droplet
function show_droplet_info() {
    local droplet_id=$(get_droplet_id)
    local droplet_ip=$(get_droplet_ip)
    local ssh_cmd=$(get_ssh_cmd)

    echo_separator
    echo "Droplet already created!"
    echo
    echo "Droplet Name: $DROPLET_NAME"
    echo "Droplet ID:   $droplet_id"
    echo "Droplet IP:   $droplet_ip"
    echo
    echo "Connect to the droplet using"
    echo
    echo "$ssh_cmd"
    echo_separator
}

# Show the logs from the new droplet
function droplet_logs_option() {
    local ssh_cmd=$(get_ssh_cmd)

    read -p "Do you want to see the config-init logs? (Y/n): " choice
    if [[ ! "$choice" =~ ^[Nn]$ ]]; then
        wait_for_ssh
        show_droplet_cloud_init_logs
    fi
}

# Wait for the new droplet to be ready for SSH connections
function wait_for_ssh() {
    local ssh_cmd=$(get_ssh_cmd)

    echo "Trying ssh connection..."
    until $ssh_cmd 'echo "SSH connection established."'; do
        echo "Waiting for the droplet to be ready for ssh connections..."
        sleep 5
    done
}

# Show the cloud-init logs from the new droplet
function show_droplet_cloud_init_logs() {
    local ssh_cmd=$(get_ssh_cmd)

    echo_separator
    echo "Showing logs from cloud-init"
    echo
    echo "tail -f $CONFIG_INIT_LOG"
    echo_separator

    trap '' SIGINT
    $ssh_cmd -t "tail -f $CONFIG_INIT_LOG"
    trap SIGINT
}

# Connect to the new droplet
function droplet_connection_option() {
    local ssh_cmd=$(get_ssh_cmd)

    echo_separator
    echo "Connect to the droplet using"
    echo
    echo "$ssh_cmd"
    echo_separator

    read -p "Do you want to connect to the droplet using ssh? (Y/n): " choice
    if [[ ! "$choice" =~ ^[Nn]$ ]]; then
        wait_for_ssh
        trap '' SIGINT
        $ssh_cmd
        trap SIGINT
    fi
}

# Delete the new droplet
function droplet_delete_option() {
    local droplet_id=$(get_droplet_id)

    echo_separator
    echo "Delete the droplet using"
    echo
    echo "dom droplet delete $dropet_id"
    echo_separator

    read -p "Do you want to delete the droplet? (Y/n): " choice
    if [[ ! "$choice" =~ ^[Nn]$ ]]; then
        echo "Stopping the droplet to collect logs before deleting..."
        dom droplet stop $droplet_id \
          && dom droplet delete $droplet_id \
          && echo "Droplet deleted."
    fi
}

# Run the whole session
function run_session() {
    show_droplet_info
    droplet_logs_option
    droplet_connection_option
    droplet_delete_option
    echo "Session ended."
}