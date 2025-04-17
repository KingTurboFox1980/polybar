#!/bin/bash

# Check if tuned-adm is installed
if ! command -v tuned-adm &> /dev/null; then
    echo "tuned-adm is not installed. Please install it and try again."
    exit 1
fi

# Check if switcherooctl is installed
if ! command -v switcherooctl &> /dev/null; then
    echo "switcherooctl is not installed. Please install it and try again."
    exit 1
fi

# Apply throughput-performance profile
sudo tuned-adm profile throughput-performance

# Launch virt-manager with GPU 0
switcherooctl launch --gpu=0 virt-manager

echo "Operation completed successfully."
