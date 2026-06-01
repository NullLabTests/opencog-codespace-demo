#!/bin/bash
# CogServer health report — generates summary of AtomSpace state
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

set -euo pipefail

HOST="${1:-localhost}"
PORT="${2:-17001}"

echo "=== CogServer Health Report ==="
echo "Generated: $(date -u +'%Y-%m-%dT%H:%M:%SZ')"
echo ""

# Check if CogServer is running
if echo '(cog-count-atoms)' | nc -w 5 "$HOST" "$PORT" 2>/dev/null | grep -q "AtomSpace"; then
    echo "Status: RUNNING"
else
    echo "Status: NOT RESPONDING"
    exit 1
fi

# Atom counts
echo ""
echo "--- Atom Counts ---"
echo '(cog-count-atoms)' | nc -w 5 "$HOST" "$PORT" 2>/dev/null | head -5

# Type distribution
echo ""
echo "--- Type Distribution ---"
echo '(map (lambda (t) (display t) (display ": ") (display (cog-count-atoms t)) (newline)) (cog-get-types))' | \
    nc -w 10 "$HOST" "$PORT" 2>/dev/null | head -20

echo ""
echo "=== Report Complete ==="
