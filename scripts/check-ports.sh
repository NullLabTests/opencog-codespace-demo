#!/bin/bash
# Port availability checker
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

PORTS="${1:-17001 18080 18888}"
HOST="${2:-localhost}"

PASS=0
FAIL=0

echo "=== Port Availability Check ==="
echo "Host: $HOST"
echo ""

for port in $PORTS; do
    if timeout 2 bash -c "echo >/dev/tcp/$HOST/$port" 2>/dev/null; then
        printf "  [OPEN]  Port %s\n" "$port"
        PASS=$((PASS + 1))
    else
        printf "  [CLOSED] Port %s\n" "$port"
        FAIL=$((FAIL + 1))
    fi
done

echo ""
echo "=== Results: $PASS open, $FAIL closed ==="

# Suggest process if port is in use
for port in $PORTS; if timeout 2 bash -c "echo >/dev/tcp/$HOST/$port" 2>/dev/null; then
    pid=$(sudo lsof -ti :"$port" 2>/dev/null || echo "")
    if [ -n "$pid" ]; then
        printf "  Port %s is used by PID %s\n" "$port" "$pid"
    fi
fi; true; done 2>/dev/null
