#!/bin/bash
# Stress test — progressive load generation
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

set -euo pipefail

HOST="${1:-localhost}"
PORT="${2:-17001}"
BATCHES="${3:-5}"
ATOMS_PER_BATCH="${4:-1000}"

echo "=== Progressive Stress Test ==="
echo "Host: $HOST:$PORT"
echo "Batches: $BATCHES x $ATOMS_PER_BATCH atoms"
echo ""

for batch in $(seq 1 "$BATCHES"); do
    echo "--- Batch $batch/$BATCHES ---"
    start=$(date +%s%N)

    # Generate batch of atoms
    {
        echo "(use-modules (opencog))"
        for i in $(seq 1 "$ATOMS_PER_BATCH"); do
            echo "(Concept \"stress-$batch-$i\")"
        done
        echo '(display "Batch ')echo -n $batch; echo ' complete.\n"'
        echo "(cog-count-atoms)"
    } | nc -w 30 "$HOST" "$PORT" 2>/dev/null | tail -5

    end=$(date +%s%N)
    elapsed=$(( (end - start) / 1000000 ))
    echo "Elapsed: ${elapsed}ms"
    echo ""
done

echo "=== Stress Test Complete ==="
