#!/bin/bash

APP_URL="http://localhost:4499"
APP_PORT=4499

echo "Checking application health at: $APP_URL"

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL")

echo "HTTP Status Code: $HTTP_STATUS"

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "Application is UP and running!"
else
  echo "Application is DOWN or not responding!"
  exit 1
fi

echo
echo "==== System Uptime Information ===="

uptime | awk -F'(,| up )' '{print "System Uptime: " $2}'

echo
echo "==== Application Uptime (Process) ===="

PID=$(lsof -nP -iTCP:"$APP_PORT" -sTCP:LISTEN -t 2>/dev/null)

if [ -n "$PID" ]; then
  START_TIME=$(ps -p "$PID" -o lstart=)
  NOW=$(date)
  APP_UPTIME=$(ps -p "$PID" -o etime=)

  echo "Process ID: $PID"
  echo "Start Time: $START_TIME"
  echo "Current Time: $NOW"
  echo "Application Uptime: $APP_UPTIME"
else
  echo "Could not find process running on port $APP_PORT"
fi
