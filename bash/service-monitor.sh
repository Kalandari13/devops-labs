#!/bin/bash
passed=0
failed=0
exit_code=0

check_service() {

    if [ "$#" -eq 0 ]; then
        echo "No services provided to check"
        exit_code=1 
    fi 
    
    mkdir -p ~/devops-labs/bash/logs
    
    for service in "$@"; do
        if [ -z "$service" ]; then
            echo "[FAIL] Empty service name"
            ((++failed))
            exit_code=1
            continue
        fi

        if systemctl is-active --quiet "$service"; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') [OK] $service is active" | tee -a ~/devops-labs/bash/logs/service-monitor.log
            if [ ${PIPESTATUS[1]} -ne 0 ]; then
                echo "[ERROR] failed to write log" >&2
                exit 1
            fi

            ((++passed))

        elif [[ $(systemctl show "$service.service" -p LoadState --value) != "loaded" ]]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') [FAIL] $service not found" | tee -a ~/devops-labs/bash/logs/service-monitor.log
            if [ ${PIPESTATUS[1]} -ne 0 ]; then
                echo "[ERROR] failed to write log" >&2
                exit 1
            fi

            ((++failed))
            exit_code=1

        else
            echo "$(date '+%Y-%m-%d %H:%M:%S') [FAIL] $service is not active" | tee -a ~/devops-labs/bash/logs/service-monitor.log
            if [ ${PIPESTATUS[1]} -ne 0 ]; then
                echo "[ERROR] failed to write log" >&2
                exit 1
            fi

            ((++failed))
            exit_code=1
        fi
    done

}


check_service "$@"

echo "Passed: $passed"
echo "Failed: $failed"
echo "exit status is $exit_code"
exit "$exit_code"


