#!/bin/bash
LOG_FILE="/var/log/monitoring.log"
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}
log_message "Starting monitoring script"
if ps aux | grep -v grep | grep './test.sh' > /dev/null; then
    log_message "Process './test.sh' is running"
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" https://test.com/monitoring/test/api)
    if [ "$RESPONSE" -ne 200 ]; then
        log_message "Monitoring server is unavailable (HTTP code: $RESPONSE)"
    else
        log_message "Monitoring server responded successfully (HTTP code: $RESPONSE)"
    fi
    PID_FILE="/tmp/test_pid"
    CURRENT_PID=$(ps aux | grep -v grep | grep './test.sh' | awk '{print $2}' | head -1)
    if [ -n "$CURRENT_PID" ]; then
        if [ -f "$PID_FILE" ]; then
            PREV_PID=$(cat "$PID_FILE")
            if [ "$CURRENT_PID" != "$PREV_PID" ]; then
                log_message "Process './test.sh' was restarted (Previous PID: $PREV_PID, New PID: $CURRENT_PID)"
            fi
        else
            log_message "Process './test.sh' detected for the first time (PID: $CURRENT_PID)"
        fi
        echo "$CURRENT_PID" > "$PID_FILE"
    else
        log_message "Error: Could not retrieve PID for './test.sh'"
    fi
else
    log_message "Process './test.sh' is not running"
fi
