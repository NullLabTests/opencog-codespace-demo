#!/bin/bash
# Docker entrypoint — starts CogServer with all services
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

set -euo pipefail

REPL_PORT="${COGSERVER_REPL_PORT:-17001}"
WEB_PORT="${COGSERVER_WEB_PORT:-18080}"
MCP_PORT="${COGSERVER_MCP_PORT:-18888}"
COGSERVER="${COGSERVER_BIN:-/usr/local/bin/cogserver}"

echo "Starting CogServer..."
echo "  REPL:  port $REPL_PORT"
echo "  Web:   port $WEB_PORT"
echo "  MCP:   port $MCP_PORT"
echo "  PID:   $$"

# Start CogServer
exec "$COGSERVER" -p "$REPL_PORT" -w "$WEB_PORT" -m "$MCP_PORT"
