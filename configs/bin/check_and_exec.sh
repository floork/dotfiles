#!/bin/bash

# Check if the command exists and is executable
if command -v "$1" >/dev/null 2>&1; then
    exec "$@"
else
    # If not, exit silently
    exit 0
fi
