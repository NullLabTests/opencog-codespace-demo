# APIS & Web Endpoints

## HTTP Endpoints (port 18080)

| Route | Method | Description |
|---|---|---|
| `/` | GET | Root — redirects to visualizer |
| `/visualizer/` | GET | Main visualizer landing page (3D graph browser) |
| `/visualizer/tree-view.html` | GET | Tree/hierarchical layout view |
| `/visualizer/type-view.html` | GET | Atoms grouped by type |
| `/visualizer/analytics.html` | GET | Statistical dashboard |
| `/visualizer/styles.css` | GET | Visualizer CSS theme |
| `/visualizer/landing.js` | GET | Main 3D graph rendering JS (Three.js / D3) |
| `/visualizer/d3min.js` | GET | D3.js library (for tree/type views) |
| `/websockets/demo.html` | GET | Interactive WebSocket shell in browser |
| `/websockets/json-test.html` | GET | JSON WebSocket developer test tool |
| `/websockets/udn.js` | GET | WebSocket client library |
| `/stats` | GET | CogServer status dashboard |
| `/shutdown` | POST | Shutdown the CogServer |

## WebSocket Endpoints (port 18080)

| Path | Protocol | Shell Type |
|---|---|---|
| `/json` | JSON text frames | JsonShell — structured JSON commands |
| `/scheme` | Raw scheme text | SchemeShell — pass scheme expressions |
| `/python` | Raw python text | PythonShell — pass python expressions |
| `/sexpr` | S-expression text | SexprShell — Lisp-style s-exprs |

### JSON Shell Protocol

Send a JSON object with `"command"` and `"body"` fields:

```json
{"command": "scheme", "body": "(ConceptNode \"hello\")"}
```

The server responds with:

```json
{"status": "ok", "result": "(ConceptNode \"hello\")\n", "type": "json"}
```

## TCP Endpoints (telnet / raw)

| Port | Protocol | Shell Type |
|---|---|---|
| 17001 | Raw TCP | SchemeShell — type scheme expressions |
| 18888 | MCP | Model Context Protocol |

## Querying via HTTP + WebSocket (Programmatic)

### Python Example (using websockets)

```python
import asyncio
import websockets
import json

async def ask_cogserver(expression):
    async with websockets.connect("ws://localhost:18080/json") as ws:
        payload = json.dumps({"command": "scheme", "body": expression})
        await ws.send(payload)
        response = await ws.recv()
        return json.loads(response)

result = asyncio.run(ask_cogserver("(cog-count-atoms)"))
print(result)
```

### JavaScript Example (browser)

```javascript
const ws = new WebSocket("ws://localhost:18080/json");

ws.onopen = () => {
    ws.send(JSON.stringify({
        command: "scheme",
        body: "(ConceptNode 'hello')"
    }));
};

ws.onmessage = (event) => {
    console.log(JSON.parse(event.data));
};
```

### Bash / curl example

```bash
# Using netcat
echo '(cog-count-atoms)' | nc localhost 17001

# Using telnet (non-interactive)
echo '(cog-count-atoms)' | telnet localhost 17001 2>/dev/null | tail -1
```
