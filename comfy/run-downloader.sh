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

DROPLET_TYPE="cpu"
DROPLET_TPL="cpu-mini"
DROPLET_NAME="downloader"
CLOUD_CONFIG="downloader"

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