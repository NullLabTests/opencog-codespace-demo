#!/bin/bash
# Integration test — verifies CogServer responds on all endpoints
set -euo pipefail

echo "=== OpenCog Integration Tests ==="
FAIL=0

# Test 1: TCP REPL port
echo -n "Test 1: TCP REPL (port 17001) ... "
if echo '(use-modules (opencog)) (cog-count-atoms)' | nc -w 5 localhost 17001 2>/dev/null | grep -q "AtomSpace"; then
    echo "PASS"
else
    echo "FAIL"
    FAIL=1
fi

# Test 2: HTTP stats endpoint
echo -n "Test 2: HTTP Stats (port 18080) ... "
if curl -sf http://localhost:18080/stats > /dev/null 2>&1; then
    echo "PASS"
else
    echo "FAIL"
    FAIL=1
fi

# Test 3: WebSocket JSON shell
echo -n "Test 3: WebSocket JSON Shell ... "
if python3 -c "
import asyncio, json, websockets
async def test():
    async with websockets.connect('ws://localhost:18080/json') as ws:
        await ws.send(json.dumps({'command': 'scheme', 'body': '(cog-count-atoms)'}))
        resp = await asyncio.wait_for(ws.recv(), timeout=5)
        assert 'ok' in resp
        print('PASS')
asyncio.run(test())
" 2>/dev/null; then
    :
else
    echo "FAIL"
    FAIL=1
fi

# Test 4: Visualizer loads
echo -n "Test 4: Visualizer Landing Page ... "
if curl -sf http://localhost:18080/visualizer/ > /dev/null 2>&1; then
    echo "PASS"
else
    echo "FAIL"
    FAIL=1
fi

echo ""
if [ "$FAIL" -eq 0 ]; then
    echo "=== All tests PASSED ==="
else
    echo "=== Some tests FAILED ==="
    exit 1
fi
