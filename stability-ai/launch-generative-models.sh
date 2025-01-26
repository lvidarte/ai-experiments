#!/bin/bash

set -e

DROPLET_TPL="cpu-mini"
DROPLET_NAME="test01"

source ../.ai_env/bin/activate

# Launch droplet
dom droplet create $DROPLET_TPL $DROPLET_NAME --cloud-config generative-models --dry-run
dom droplet list

deactivate
