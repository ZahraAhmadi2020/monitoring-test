#DevOps 
# Monitoring Test Project

This project contains a Bash script (`monitoring.sh`) that monitors a process named `test.sh`, sends an HTTPS request to a monitoring server, and logs the process status and server response. It uses `systemd` to run the script automatically every minute.

## Files
- `monitoring.sh`: Main script to monitor the `test.sh` process and send HTTPS requests.
- `test.sh`: A dummy process for testing.
- `systemd/monitoring.service`: Systemd service file to run the script.
- `systemd/monitoring.timer`: Systemd timer to execute the script every minute.
- `/var/log/monitoring.log`: Log file for monitoring output (not included in the repository).

## Setup
1. Copy `monitoring.sh` and `test.sh` to `/home/yourusername/projects/monitoring/`.
2. Copy `monitoring.service` and `monitoring.timer` to `/etc/systemd/system/`.
3. Run:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable monitoring.timer
   sudo systemctl start monitoring.timer
