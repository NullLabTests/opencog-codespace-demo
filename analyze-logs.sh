#!/bin/bash
# CogServer log analyzer — extracts key metrics from logs
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

set -euo pipefail

LOGFILE="${1:-/tmp/cogserver.log}"

if [ ! -f "$LOGFILE" ]; then
    echo "Log file not found: $LOGFILE"
    exit 1
fi

echo "=== CogServer Log Analysis ==="
echo "File: $LOGFILE"
echo ""

# Uptime estimate from first and last timestamps
first=$(head -1 "$LOGFILE" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' || echo "unknown")
last=$(tail -1 "$LOGFILE" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' || echo "unknown")
echo "First entry: $first"
echo "Last entry:  $last"

# Count event types
echo ""
echo "Event counts:"
grep -coE '(Error|Warning|Info|Debug)' "$LOGFILE" 2>/dev/null | \
    awk '{print "  " $0}' || echo "  (none)"

# Connection events
conns=$(grep -c "connect" "$LOGFILE" 2>/dev/null || echo 0)
discs=$(grep -c "disconnect" "$LOGFILE" 2>/dev/null || echo 0)
echo "Connections:    $conns"
echo "Disconnections: $discs"

# Errors
errors=$(grep -ci "error" "$LOGFILE" 2>/dev/null || echo 0)
echo "Errors:         $errors"

echo ""
echo "=== Analysis Complete ==="
