#!/usr/bin/env bash
# start-cogserver.sh — Start or restart the CogServer
set -e

COGSERVER="$(command -v cogserver 2>/dev/null || echo /usr/local/bin/cogserver)"
REPL_PORT=${REPL_PORT:-17001}
WEB_PORT=${WEB_PORT:-18080}
MCP_PORT=${MCP_PORT:-18888}

# Kill existing instance if running
if pgrep cogserver > /dev/null 2>&1; then
    echo "Stopping existing CogServer (PID $(pgrep cogserver))..."
    pkill cogserver 2>/dev/null || true
    sleep 1
fi

# Start
echo "Starting CogServer on ports $REPL_PORT (REPL) / $WEB_PORT (Web) / $MCP_PORT (MCP)..."
nohup "$COGSERVER" -p "$REPL_PORT" -w "$WEB_PORT" -m "$MCP_PORT" > /tmp/cogserver.log 2>&1 &
sleep 1

# Verify
if pgrep cogserver > /dev/null 2>&1; then
    echo "CogServer started OK (PID $(pgrep cogserver))."
    echo "  REPL (telnet): localhost:$REPL_PORT"
    echo "  Web UI:        http://localhost:$WEB_PORT/visualizer/"
    echo "  MCP:           localhost:$MCP_PORT"
else
    echo "ERROR: CogServer failed to start. Check /tmp/cogserver.log"
    exit 1
fi
