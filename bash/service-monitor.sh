#!/bin/bash
passed=0
failed=0
exit_code=0

check_service() {

    if [ "$#" -eq 0 ]; then
        echo "No services provided to check"
        exit_code=1 
    fi 

    for service in "$@"; do
        if [ -z "$service" ]; then
            echo "[FAIL] Empty service name"
            ((++failed))
            exit_code=1
            continue
        fi

        if systemctl is-active --quiet "$service"; then
            echo "[OK] $service is active"
            ((++passed))

        elif [[ $(systemctl show "$service.service" -p LoadState --value) != "loaded" ]]; then
            echo "[FAIL] $service not found"
            ((++failed))
            exit_code=1

        else
            echo "[FAIL] $service is not active"
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


