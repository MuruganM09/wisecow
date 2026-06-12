# Problem Statement 2 — DevOps Scripts

## 1. System Health Monitoring Script (system_health_monitor.sh)
Monitors CPU, memory, disk usage, and running processes on a Linux system.
Sends alerts to console and /tmp/system_health.log if usage exceeds thresholds (default 80%).
Also displays the top 5 CPU-consuming processes.

### Usage
./system_health_monitor.sh

## 2. Application Health Checker (app_health_checker.sh)
Checks if specified applications/URLs are reachable by sending HTTP requests and verifying response codes.
Logs DOWN alerts to /tmp/app_health.log.

### Usage
Edit the APPS array in the script with name="url" pairs, then run:
./app_health_checker.sh
