#!/bin/bash
# Docker healthcheck — verifies CogServer is responding
set -euo pipefail

# Check HTTP stats endpoint
if curl -sf http://localhost:18080/stats > /dev/null 2>&1; then
    exit 0
fi

# Fallback: check TCP REPL port
if timeout 2 bash -c 'echo "" | nc localhost 17001 2>/dev/null'; then
    exit 0
fi

exit 1
