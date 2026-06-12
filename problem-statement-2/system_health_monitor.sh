#!/bin/bash

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

LOGFILE="/tmp/system_health.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

log_alert() {
    echo "[$TIMESTAMP] ALERT: $1" | tee -a "$LOGFILE"
}

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)
echo "[$TIMESTAMP] CPU Usage: ${CPU_USAGE}%"
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    log_alert "High CPU usage: ${CPU_USAGE}% (threshold: ${CPU_THRESHOLD}%)"
fi

MEM_USAGE=$(free | awk '/Mem/{printf("%.0f", $3/$2 * 100)}')
echo "[$TIMESTAMP] Memory Usage: ${MEM_USAGE}%"
if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
    log_alert "High Memory usage: ${MEM_USAGE}% (threshold: ${MEM_THRESHOLD}%)"
fi

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
echo "[$TIMESTAMP] Disk Usage: ${DISK_USAGE}%"
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    log_alert "High Disk usage: ${DISK_USAGE}% (threshold: ${DISK_THRESHOLD}%)"
fi

PROCESS_COUNT=$(ps aux --no-headers | wc -l)
echo "[$TIMESTAMP] Running Processes: $PROCESS_COUNT"

echo "[$TIMESTAMP] Top 5 CPU-consuming processes:"
ps aux --sort=-%cpu | head -6

echo "----------------------------------------"
echo "Health check complete. Alerts (if any) logged to $LOGFILE"
