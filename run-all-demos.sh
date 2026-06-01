#!/bin/bash
# Run all demo scripts sequentially and report results
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

set -euo pipefail

COGSERVER_HOST="${1:-localhost}"
COGSERVER_PORT="${2:-17001}"
TIMEOUT="${3:-30}"
PASS=0
FAIL=0
TOTAL=0

report() {
    local script="$1" status="$2"
    TOTAL=$((TOTAL + 1))
    if [ "$status" = "PASS" ]; then
        PASS=$((PASS + 1))
        printf "  [PASS] %s\n" "$script"
    else
        FAIL=$((FAIL + 1))
        printf "  [FAIL] %s\n" "$script"
    fi
}

echo "=== OpenCog Demo Runner ==="
echo "Host: $COGSERVER_HOST:$COGSERVER_PORT"
echo ""

for script in demo/comprehensive-demo.scm demo/evaluation-demo.scm \
              demo/truth-values.scm demo/values-api.scm; do
    if [ ! -f "$script" ]; then
        report "$script" "FAIL (not found)"
        continue
    fi
    if cat "$script" | nc -w "$TIMEOUT" "$COGSERVER_HOST" "$COGSERVER_PORT" 2>/dev/null \
        | grep -q "Done.\|Complete\|PASS"; then
        report "$script" "PASS"
    else
        report "$script" "FAIL"
    fi
done

for script in demo/use-cases/*.scm; do
    if [ ! -f "$script" ]; then continue; fi
    if cat "$script" | nc -w "$TIMEOUT" "$COGSERVER_HOST" "$COGSERVER_PORT" 2>/dev/null \
        | grep -q "Done.\|Complete\|PASS"; then
        report "$script" "PASS"
    else
        report "$script" "FAIL"
    fi
done

echo ""
echo "=== Results: $PASS/$TOTAL passed, $FAIL failed ==="
exit $FAIL
