#!/bin/bash

appname="DevOps Server Monitor"
current_user=$(whoami)
server_name=$(hostname)
report_date=$(date)


echo "Application: $appname"
echo "Username: $current_user"
echo "Hostname: $server_name"
echo "Date: $report_date"
echo "$appname completed successfully"
