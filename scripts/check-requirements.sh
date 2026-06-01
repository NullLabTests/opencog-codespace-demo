#!/bin/bash
# System requirements check
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

PASS=0
FAIL=0

check() {
    local name="$1" result="$2"
    if [ "$result" -eq 0 ]; then
        PASS=$((PASS + 1))
        printf "  [PASS] %s\n" "$name"
    else
        FAIL=$((FAIL + 1))
        printf "  [FAIL] %s\n" "$name"
    fi
}

echo "=== System Requirements Check ==="
echo ""

check "OS: Ubuntu 24.04" "$(grep -c 'Ubuntu 24.04' /etc/os-release 2>/dev/null || true)"
check "Kernel: Linux" "$(uname -s | grep -c Linux || true)"
check "Arch: x86_64" "$(uname -m | grep -c x86_64 || true)"
check "CPU cores >= 2" "$([[ $(nproc) -ge 2 ]] && echo 0 || echo 1)"
check "RAM >= 4 GB" "$([[ $(free -g | awk '/^Mem:/{print $2}') -ge 4 ]] && echo 0 || echo 1)"
check "Disk >= 10 GB free" "$([[ $(df / | awk 'NR==2{print $4}') -ge 10485760 ]] && echo 0 || echo 1)"

echo ""
check "Docker installed" "$(command -v docker >/dev/null && echo 0 || echo 1)"
check "Docker Compose installed" "$(command -v docker-compose >/dev/null || docker compose version >/dev/null 2>&1; echo $?)"
check "Git installed" "$(command -v git >/dev/null && echo 0 || echo 1)"
check "Curl installed" "$(command -v curl >/dev/null && echo 0 || echo 1)"
check "Netcat installed" "$(command -v nc >/dev/null && echo 0 || echo 1)"

echo ""
echo "=== Results: $PASS/$((PASS+FAIL)) passed, $FAIL failed ==="
exit $FAIL
