# OpenCog AtomSpace Demo
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog


#!/usr/bin/env python3
"""loadtest.py — Simple load test for CogServer.

Creates N atoms in batches over WebSocket and measures throughput.

Usage:
    python3 loadtest.py --count 1000 --batch 100 --host localhost --port 18080
"""

import asyncio
import json
import time
import argparse
import websockets


async def send_scheme(ws, expr):
    await ws.send(json.dumps({"command": "scheme", "body": expr}))
    return await ws.recv()


async def load_test(count=100, batch=10, host="localhost", port=18080):
    uri = f"ws://{host}:{port}/json"
    print(f"Connecting to {uri} ...")
    async with websockets.connect(uri) as ws:
        # Warm up
        await send_scheme(ws, "(use-modules (opencog))")

        # Create atoms in batches
        start = time.time()
        for i in range(0, count, batch):
            batch_end = min(i + batch, count)
            expr = " ".join(
                f'(Concept "loadtest-{j}")' for j in range(i, batch_end)
            )
            await send_scheme(ws, expr)

        elapsed = time.time() - start
        throughput = count / elapsed

        # Verify count
        resp = await send_scheme(ws, "(cog-count-atoms)")
        data = json.loads(resp)

        print(f"Created {count} atoms in {elapsed:.2f}s")
        print(f"Throughput: {throughput:.0f} atoms/second")
        print(f"Atom count response: {data.get('result', 'N/A')[:80]}")

        # Clean up
        expr = " ".join(f'(cog-delete (Concept "loadtest-{j}"))' for j in range(count))
        await send_scheme(ws, expr)
        print("Cleaned up test atoms.")


def main():
    parser = argparse.ArgumentParser(description="Load test for CogServer")
    parser.add_argument("--count", type=int, default=100, help="Number of atoms to create")
    parser.add_argument("--batch", type=int, default=10, help="Batch size")
    parser.add_argument("--host", default="localhost", help="CogServer host")
    parser.add_argument("--port", type=int, default=18080, help="WebSocket port")
    args = parser.parse_args()

    asyncio.run(load_test(args.count, args.batch, args.host, args.port))


if __name__ == "__main__":
    main()
