#!/usr/bin/env python3
# Self-test report — validates CogServer and basic AtomSpace operations
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

import asyncio
import json
import sys
import time
import websockets

PASS = 0
FAIL = 0

def report(name, ok, detail=""):
    global PASS, FAIL
    if ok:
        PASS += 1
        print(f"  [PASS] {name}")
    else:
        FAIL += 1
        print(f"  [FAIL] {name} — {detail}")

async def ask(ws, expr):
    await ws.send(json.dumps({"command": "scheme", "body": expr}))
    return json.loads(await ws.recv())

async def run_tests(host, port):
    global PASS, FAIL
    print(f"=== CogServer Self-Test Report ===")
    print(f"Host: {host}:{port}")
    print(f"Time: {time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())}\n")

    uri = f"ws://{host}:{port}/json"
    try:
        async with websockets.connect(uri, ping_timeout=5) as ws:
            report("WebSocket connection", True)

            r = await ask(ws, "(cog-count-atoms)")
            report("Atom count query", r.get("status") == "ok", str(r.get("result", ""))[:80])

            r = await ask(ws, '(Concept "self-test")')
            report("Create Concept atom", r.get("status") == "ok")

            r = await ask(ws, '(Inheritance (Concept "self-test") (Concept "test"))')
            report("Create Inheritance link", r.get("status") == "ok")

            r = await ask(ws, '(cog-evaluate! (Plus (Number 1) (Number 2)))')
            report("Arithmetic (1+2)", "3" in str(r.get("result", "")))

            r = await ask(ws, '(cog-evaluate! (GreaterThan (Number 10) (Number 5)))')
            report("Comparison (10>5)", "True" in str(r.get("result", "")))

            r = await ask(ws, '(cog-delete-recursive (Concept "self-test"))')
            report("Delete atoms", r.get("status") == "ok")

    except Exception as e:
        report(f"Connection to {host}:{port}", False, str(e))

    print(f"\n=== Results: {PASS}/{PASS+FAIL} passed, {FAIL} failed ===")
    return FAIL == 0

if __name__ == "__main__":
    host = sys.argv[1] if len(sys.argv) > 1 else "localhost"
    port = int(sys.argv[2]) if len(sys.argv) > 2 else 18080
    ok = asyncio.run(run_tests(host, port))
    sys.exit(0 if ok else 1)
