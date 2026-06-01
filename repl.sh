#!/bin/bash
# REPL helper — quick connection to CogServer
set -euo pipefail

PORT="${1:-17001}"

if command -v rlwrap &> /dev/null; then
    RLWRAP="rlwrap"
else
    RLWRAP=""
fi

echo "Connecting to CogServer on port $PORT..."
echo "Type Scheme expressions. Ctrl-D to exit."
echo ""

exec $RLWRAP telnet localhost "$PORT"
