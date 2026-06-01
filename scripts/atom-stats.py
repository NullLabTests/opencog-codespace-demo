#!/usr/bin/env python3
# Atom type statistics — report type distribution
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

import asyncio
import json
import sys
import websockets

async def get_type_counts(host="localhost", port=18080):
    uri = f"ws://{host}:{port}/json"
    async with websockets.connect(uri) as ws:
        expr = """
        (map (lambda (t)
            (list (cog-name t) (cog-count-atoms t)))
            (cog-get-types))
        """
        await ws.send(json.dumps({"command": "scheme", "body": expr}))
        resp = json.loads(await ws.recv())
        return resp.get("result", "")

def parse_counts(raw):
    types = {}
    for match in __import__("re").finditer(r'\((\S+)\s+(\d+)\)', raw):
        name, count = match.groups()
        if int(count) > 0:
            types[name] = int(count)
    return types

async def main():
    host = sys.argv[1] if len(sys.argv) > 1 else "localhost"
    print(f"=== Atom Type Statistics ===\n")
    raw = await get_type_counts(host)
    counts = parse_counts(raw)
    total = sum(counts.values())
    sorted_types = sorted(counts.items(), key=lambda x: -x[1])
    for name, count in sorted_types[:30]:
        pct = count / total * 100 if total else 0
        bar = "█" * int(pct / 2)
        print(f"  {name:30s} {count:6d} ({pct:5.1f}%) {bar}")
    print(f"\n  {'TOTAL':30s} {total:6d}")

asyncio.run(main())
