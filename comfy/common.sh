#!/bin/bash

# ============================================
# ALERT: Don't run this file directly.
# Use this file by sourcing it in your script.
# ============================================

DROPLET_IP=""
SSH_CMD=""


# Echo a separator line
function echo_separator() {
    echo "----------------------------------------------------------------"
}

# Get the IP address of the new droplet
function get_droplet_ip() {
    if [ "$DROPLET_IP" == "" ]; then
        DROPLET_IP=$(dom droplet list | grep $DROPLET_NAME | sed -n 's/.*PublicIP: \([^,]*\).*/\1/p')
    fi

    if [[ -z "$DROPLET_IP" || "$DROPLET_IP" == "None" ]]; then
        echo "Failed to get IP address for the new droplet."
        exit 1
    fi
    
    echo "$DROPLET_IP"
}

# Get the SSH command to connect to the new droplet
function get_ssh_cmd() {
    if [ "$SSH_CMD" == "" ]; then
        local droplet_ip=$(get_droplet_ip)
        SSH_CMD="ssh -i $IDENTITY_FILE root@$droplet_ip"
    fi

    echo "$SSH_CMD"
}

# Show the information about the new droplet
function show_droplet_info() {
    local droplet_ip=$(get_droplet_ip)
    local ssh_cmd=$(get_ssh_cmd)

    echo_separator
    echo "Droplet already created!"
    echo
    echo "Droplet Name: $DROPLET_NAME"
    echo "Droplet IP: $droplet_ip"
    echo
    echo "Connect to the droplet using"
    echo "$ssh_cmd"
    echo_separator
}

# Show the logs from the new droplet
function show_droplet_logs() {
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
    echo "Showing logs from $CONFIG_INIT_LOG"
    echo_separator
    $ssh_cmd -t "tail -f $CONFIG_INIT_LOG"
}