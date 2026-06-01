#!/bin/bash
# Comprehensive demo test — runs all scripts and validates output
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

set -euo pipefail

HOST="${1:-localhost}"
PORT="${2:-17001}"
TIMEOUT="${3:-30}"
FAIL=0
TOTAL=0

test_demo() {
    local script="$1" expected="$2"
    TOTAL=$((TOTAL + 1))
    local result
    result=$(cat "$script" | nc -w "$TIMEOUT" "$HOST" "$PORT" 2>/dev/null)
    if echo "$result" | grep -q "$expected"; then
        printf "  [PASS] %s\n" "$script"
    else
        printf "  [FAIL] %s (expected '%s' in output)\n" "$script" "$expected"
        FAIL=$((FAIL + 1))
    fi
}

echo "=== Comprehensive Demo Test ==="
echo ""

# Core functionality tests
test_demo "demo/comprehensive-demo.scm" "Done"
test_demo "demo/truth-values.scm" "Done"
test_demo "demo/values-api.scm" "Done"
test_demo "demo/evaluation-demo.scm" "Done"

# Use case tests
test_demo "demo/use-cases/taxonomy.scm" "Done"
test_demo "demo/use-cases/expert-system.scm" "Done"
test_demo "demo/use-cases/temporal.scm" "Done"
test_demo "demo/use-cases/semantic-net.scm" "Done"
test_demo "demo/use-cases/analogies.scm" "Done"
test_demo "demo/use-cases/planning.scm" "Done"
test_demo "demo/use-cases/family-tree.scm" "Done"
test_demo "demo/use-cases/math-reasoning.scm" "Done"
test_demo "demo/use-cases/commonsense.scm" "Done"
test_demo "demo/use-cases/rewriting.scm" "Done"
test_demo "demo/use-cases/reasoning-pipeline.scm" "Done"
test_demo "demo/use-cases/game-rule-engine.scm" "Done"
test_demo "demo/use-cases/query-optimization.scm" "Done"
test_demo "demo/use-cases/sensor-integration.scm" "Done"
test_demo "demo/use-cases/chatbot-memory.scm" "Done"
test_demo "demo/use-cases/diagnostics.scm" "Done"
test_demo "demo/use-cases/geography.scm" "Done"
test_demo "demo/use-cases/music-theory.scm" "Done"
test_demo "demo/use-cases/recipe-knowledge.scm" "Done"

echo ""
echo "=== Results: $((TOTAL - FAIL))/$TOTAL passed, $FAIL failed ==="
exit $FAIL
