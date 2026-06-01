# Integration Guide — Using the AtomSpace from Any Language

The AtomSpace speaks **three protocols** on the wire:
1. **Raw TCP** (port 17001) — Scheme expressions over telnet
2. **WebSocket** (port 18080) — JSON or raw text frames
3. **HTTP** (port 18080) — REST-style endpoints for stats and status

This guide shows how to connect from multiple languages.

---

## Python

### Using `websockets` library

```python
import asyncio
import json
import websockets

async def ask_cogserver(expression, host="localhost", port=18080):
    uri = f"ws://{host}:{port}/json"
    async with websockets.connect(uri) as ws:
        payload = json.dumps({"command": "scheme", "body": expression})
        await ws.send(payload)
        response = await ws.recv()
        return json.loads(response)

async def main():
    # Create atoms
    r1 = await ask_cogserver('(ConceptNode "python-test")')
    print("Created:", r1)

    # Query
    r2 = await ask_cogserver("(cog-count-atoms)")
    print("Count:", r2)

    # Arithmetic
    r3 = await ask_cogserver("(cog-evaluate! (Plus (Number 3) (Number 4)))")
    print("3 + 4 =", r3)

asyncio.run(main())
```

### Using raw sockets (telnet-style)

```python
import socket

def telnet_command(expression, host="localhost", port=17001):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(5)
    sock.connect((host, port))
    sock.sendall((expression + "\n").encode())
    response = b""
    try:
        while True:
            chunk = sock.recv(4096)
            if not chunk:
                break
            response += chunk
    except socket.timeout:
        pass
    sock.close()
    return response.decode()

print(telnet_command("(cog-count-atoms)"))
```

---

## JavaScript (Node.js / Browser)

### Node.js with `ws` library

```javascript
const WebSocket = require('ws');

async function askCogserver(expression) {
    return new Promise((resolve, reject) => {
        const ws = new WebSocket('ws://localhost:18080/json');
        ws.on('open', () => {
            ws.send(JSON.stringify({
                command: 'scheme',
                body: expression
            }));
        });
        ws.on('message', (data) => {
            resolve(JSON.parse(data.toString()));
            ws.close();
        });
        ws.on('error', reject);
    });
}

(async () => {
    const r1 = await askCogserver('(ConceptNode "js-test")');
    console.log('Created:', r1.result);

    const r2 = await askCogserver('(cog-count-atoms)');
    console.log('Atoms:', r2.result);
})();
```

### Browser (WebSocket API)

```javascript
const ws = new WebSocket('ws://localhost:18080/json');

ws.onopen = () => {
    ws.send(JSON.stringify({
        command: 'scheme',
        body: '(ConceptNode "browser-test")'
    }));
};

ws.onmessage = (event) => {
    const response = JSON.parse(event.data);
    console.log(response.result);
    document.getElementById('output').textContent = response.result;
};

ws.onerror = (err) => {
    console.error('WebSocket error:', err);
};
```

---

## curl / Bash

### HTTP Stats API

```bash
# Get server status as JSON
curl -s http://localhost:18080/stats | python3 -m json.tool
```

### WebSocket via Bash (using `websocat`)

```bash
# Install websocat
# cargo install websocat
# or: brew install websocat

echo '{"command":"scheme","body":"(cog-count-atoms)"}' | \
    websocat ws://localhost:18080/json
```

### Raw TCP via netcat

```bash
echo '(ConceptNode "bash-test") (cog-count-atoms)' | nc localhost 17001
```

---

## Go

```go
package main

import (
    "encoding/json"
    "fmt"
    "log"
    "net/url"
    "github.com/gorilla/websocket"
)

func main() {
    u := url.URL{Scheme: "ws", Host: "localhost:18080", Path: "/json"}
    conn, _, err := websocket.DefaultDialer.Dial(u.String(), nil)
    if err != nil {
        log.Fatal("dial:", err)
    }
    defer conn.Close()

    msg, _ := json.Marshal(map[string]string{
        "command": "scheme",
        "body":    "(ConceptNode \"go-test\")",
    })
    conn.WriteMessage(websocket.TextMessage, msg)

    _, response, _ := conn.ReadMessage()
    fmt.Println(string(response))
}
```

---

## Ruby

```ruby
require 'websocket-client-simple'

ws = WebSocket::Client::Simple.connect 'ws://localhost:18080/json'

ws.on :message do |msg|
  puts msg.data
  ws.close
end

ws.on :open do
  ws.send JSON.generate({
    command: 'scheme',
    body: '(ConceptNode "ruby-test")'
  })
end

sleep 1
```

---

## Rust

```rust
use tungstenite::{connect, Message};
use url::Url;

fn main() {
    let (mut socket, _) = connect(Url::parse("ws://localhost:18080/json").unwrap()).unwrap();
    
    let msg = serde_json::json!({
        "command": "scheme",
        "body": "(ConceptNode \"rust-test\")"
    });
    
    socket.send(Message::Text(msg.to_string())).unwrap();
    
    let response = socket.read().unwrap();
    println!("{}", response.to_text().unwrap());
}
```

---

## WebSocket JSON Protocol Reference

### Request Format

```json
{
    "command": "scheme",
    "body": "(ConceptNode \"hello\")"
}
```

Supported `command` values:
| Command | Body Type | Description |
|---|---|---|
| `scheme` | Scheme expression string | Evaluate as Scheme |
| `python` | Python expression string | Evaluate as Python |
| `json` | JSON inline | Reserved |
| `sexpr` | S-expression string | Evaluate as S-expression |

### Response Format

```json
{
    "status": "ok",
    "result": "(ConceptNode \"hello\")\n",
    "type": "json"
}
```

On error:

```json
{
    "status": "error",
    "result": "Error message here",
    "type": "json"
}
```
