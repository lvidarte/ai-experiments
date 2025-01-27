#!/bin/bash

set -e

DROPLET_TPL="cpu-mini"
#DROPLET_TPL="nvidia-h100"

DROPLET_NAME="test01-cpu"
#DROPLET_NAME="test01-gpu"

source ../.ai_env/bin/activate

# Test
#dom droplet create $DROPLET_TPL $DROPLET_NAME --cloud-config generative-models --dry-run
dom droplet create $DROPLET_TPL $DROPLET_NAME --cloud-config image-to-video --dry-run
dom droplet list

deactivate