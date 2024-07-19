#!/bin/bash

"""
Description:
This script initializes and sets up the development environment for the project.

Steps:
1. Logs the start time of the script execution.
2. Creates a virtual environment using Python 3.10.
3. Activates the created virtual environment.
4. Installs the necessary development dependencies from requirements_dev.txt.
5. Logs the end time of the script execution.

Commands:
- echo: Prints messages to the terminal, including timestamps.
- conda create: Creates a new conda virtual environment.
- source activate: Activates the conda virtual environment.
- pip install: Installs Python packages from the specified requirements file.

"""

# Log file
LOG_FILE="setup.log"

# Function to log messages with timestamps
log() {
    local MESSAGE="$1"
    echo "[$(date)]: $MESSAGE" | tee -a "$LOG_FILE"
}

# Start script
log "START"

# Ensure the log file is writable
if [ -f "$LOG_FILE" ]; then
    > "$LOG_FILE"  # Truncate the file if it exists
else
    touch "$LOG_FILE"  # Create the file if it does not exist
fi

if [ ! -w "$LOG_FILE" ]; then
    echo "[$(date)]: ERROR: Log file $LOG_FILE is not writable"
    exit 1
fi

# Step 1: Create virtual environment with Python 3.10
log "Creating env with Python 3.10 version"
conda create --prefix ./env python=3.10 -y >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    log "Failed to create conda environment"
    exit 1
fi

# Step 2: Activate the environment
log "Activating the environment"
source activate ./env >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    log "Failed to activate conda environment"
    exit 1
fi

# Step 3: Install development requirements
if [ -f requirements_dev.txt ]; then
    log "Installing the dev requirements"
    pip install -r requirements_dev.txt >> "$LOG_FILE" 2>&1
    if [ $? -ne 0 ]; then
        log "Failed to install development requirements"
        exit 1
    fi
else
    log "requirements_dev.txt file not found"
    exit 1
fi

# End script
log "END"


# echo [$(date)]: "START"

# echo [$(date)]: "creating env with python 3.10 version" 

# conda create --prefix ./env python=3.10 -y

# echo [$(date)]: "activating the environment" 

# source activate ./env

# echo [$(date)]: "installing the dev requirements" 

# pip install -r requirements_dev.txt

# echo [$(date)]: "END" 