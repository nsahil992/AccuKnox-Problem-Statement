#!/bin/bash

# Web Server Log Analyzer

LOG_FILE="/var/log/nginx/access.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "====== Web Server Log Report ======"
echo "Log file: $LOG_FILE"
echo

TOTAL_REQ=$(wc -l < "$LOG_FILE")
echo "Total Requests: $TOTAL_REQ"

ERROR_404=$(grep " 404 " "$LOG_FILE" | wc -l)
echo "Total 404 Errors: $ERROR_404"

echo
echo "Top 5 Requested Pages:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5

echo
echo "Top 5 IP Addresses:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5

echo "==================================="
