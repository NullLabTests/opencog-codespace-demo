#!/bin/bash
# Docker cleanup — removes stopped containers and dangling images
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

echo "=== Docker Cleanup ==="

echo -n "Removing stopped containers... "
docker container prune -f > /dev/null 2>&1 && echo "done"

echo -n "Removing dangling images... "
docker image prune -f > /dev/null 2>&1 && echo "done"

echo -n "Removing unused networks... "
docker network prune -f > /dev/null 2>&1 && echo "done"

echo -n "Removing build cache... "
docker builder prune -f > /dev/null 2>&1 && echo "done"

echo -n "Checking disk usage... "
docker system df 2>/dev/null | head -10

echo "=== Cleanup Complete ==="
