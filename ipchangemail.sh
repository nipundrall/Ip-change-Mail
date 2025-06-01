#!/bin/bash
## Install Postfix and mailx 
##  Set Cron job using crontab -e with format {* * * * * /file/path/name.sh > /file/path/name.txt 2>&1} and have a output path too for logs

# Configurations
LOCKFILE="/tmp/ip_alert.lock"
IPFILE="/tmp/last_ip.txt"
SUBJECT="Public IP Address Changed"
TO="Receiver@example.com"
FROM="Sender@example.com"

# Get current public IP
CURRENT_IP=$(curl -s https://api.ipify.org)

if [ -z "$CURRENT_IP" ]; then
    echo "Failed to retrieve current IP address."
    exit 2
fi

# If lockfile exists, do not send email again
if [ -f "$LOCKFILE" ]; then
    echo "Alert already sent. Reset required to send again."
    exit 1
fi

# Get previously recorded IP
if [ -f "$IPFILE" ]; then
    LAST_IP=$(cat "$IPFILE")
else
    LAST_IP=""
fi

# Compare IPs
if [ "$CURRENT_IP" != "$LAST_IP" ]; then
    echo "IP has changed from $LAST_IP to $CURRENT_IP"
    
    # Send email alert
    echo "Your public IP address has changed to: $CURRENT_IP" | \
	    mailx -s "$SUBJECT" -r "$FROM" "$TO"

    if [ $? -eq 0 ]; then
        echo "Email sent successfully."
        echo "$CURRENT_IP" > "$IPFILE"
        touch "$LOCKFILE"
    else
        echo "Failed to send email."
        exit 3
    fi
else
    echo "IP address has not changed. No email sent."
fi

