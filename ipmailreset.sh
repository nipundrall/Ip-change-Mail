#!/bin/bash

LOCKFILE="/tmp/ip_alert.lock"

if [ -f "$LOCKFILE" ]; then
    rm "$LOCKFILE"
    echo "Reset complete. Script can send alert again if IP changes."
else
    echo "No lockfile found. Nothing to reset."
fi

