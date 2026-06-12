#!/bin/bash

LOGFILE="/tmp/app_health.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

declare -A APPS
APPS["Google"]="https://www.google.com"
APPS["GitHub"]="https://github.com"
APPS["Local-Wisecow"]="http://127.0.0.1:35425"

echo "[$TIMESTAMP] Application Health Check Report"
echo "----------------------------------------"

for app in "${!APPS[@]}"; do
    url="${APPS[$app]}"
    HTTP_CODE=$(curl -k -o /dev/null -s -w "%{http_code}" --connect-timeout 5 "$url")

    if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 400 ]; then
        STATUS="UP"
    else
        STATUS="DOWN"
        echo "[$TIMESTAMP] ALERT: $app is DOWN (HTTP $HTTP_CODE)" | tee -a "$LOGFILE"
    fi

    printf "%-15s URL: %-40s Status: %-5s HTTP: %s\n" "$app" "$url" "$STATUS" "$HTTP_CODE"
done

echo "----------------------------------------"
echo "Report complete. Alerts (if any) logged to $LOGFILE"
