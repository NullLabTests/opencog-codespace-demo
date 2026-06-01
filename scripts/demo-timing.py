#!/usr/bin/env python3
# Demo timing report — measures execution time of each demo script
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

import subprocess
import sys
import time

HOST = sys.argv[1] if len(sys.argv) > 1 else "localhost"
PORT = sys.argv[2] if len(sys.argv) > 2 else "17001"
SCRIPTS = [
    "demo/comprehensive-demo.scm",
    "demo/evaluation-demo.scm",
    "demo/truth-values.scm",
    "demo/values-api.scm",
    "demo/rest-api.scm",
]

print(f"=== Demo Timing Report ===")
print(f"Host: {HOST}:{PORT}\n")

results = []
for script in SCRIPTS:
    start = time.time()
    try:
        result = subprocess.run(
            ["nc", "-w", "30", HOST, PORT],
            input=open(script, "rb").read(),
            capture_output=True, timeout=35
        )
        elapsed = time.time() - start
        lines = len(result.stdout.decode().strip().split("\n"))
        results.append((script, elapsed, lines, "ok"))
        print(f"  {script:45s} {elapsed:6.2f}s  {lines:4d} lines")
    except Exception as e:
        elapsed = time.time() - start
        results.append((script, elapsed, 0, str(e)))
        print(f"  {script:45s} {elapsed:6.2f}s  FAILED: {e}")

print(f"\nTotal: {sum(r[1] for r in results):.2f}s across {len(results)} scripts")
