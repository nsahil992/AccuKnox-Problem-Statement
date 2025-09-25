#!/bin/bash

# Application Health Checker

APP_URL="http://localhost:4499"

STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" "$APP_URL")

echo "Checking application health at: $APP_URL"
echo "HTTP Status Code: $STATUS_CODE"

if [ "$STATUS_CODE" -eq 200 ]; then
    echo "Application is UP and running!"
else
    echo "Application is DOWN or not responding!"
fi
