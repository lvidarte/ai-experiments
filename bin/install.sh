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

set -e 

# Define the virtual environment directory
VENV_DIR=".env"

# Check if the .venv directory exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Virtual environment not found. Creating one..."
    
    # Check if python3 is installed
    if ! command -v python3 &> /dev/null; then
        echo "Error: python3 is not installed. Please install it and try again."
        exit 1
    fi

    # Create the virtual environment
    python3 -m venv "$VENV_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create the virtual environment."
        exit 1
    fi
    echo "Virtual environment created successfully in $VENV_DIR"

    # Activate the virtual environment
    source "$VENV_DIR/bin/activate"

    # Check if requirements.txt exists and install dependencies
    if [ -f "requirements.txt" ]; then
        echo "Installing dependencies from requirements.txt..."
        pip install --upgrade pip
        pip install -r requirements.txt
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install dependencies."
            deactivate
            exit 1
        fi
        echo "Dependencies installed successfully."
    else
        echo "No requirements.txt found. Skipping dependency installation."
    fi
else
    echo "Virtual environment already exists in $VENV_DIR"
fi
