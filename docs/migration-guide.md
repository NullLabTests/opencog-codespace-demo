# Migration Guide — OpenCog Classic to Hyperon / MeTTa

This guide helps you move from **OpenCog Classic** (the AtomSpace stack
in this repo) to **OpenCog Hyperon** (the next-generation architecture
using the MeTTa language).

## Why Migrate?

| Classic | Hyperon / MeTTa |
|---|---|
| C++ codebase | Rust + Python + WASM |
| Scheme (Guile) scripting | MeTTa language (native) |
| Single-process AtomSpace | Distributed AtomSpace (DAS) |
| Manual build/install | pip install hyperon |
| PLANNED feature-freeze | Active development |
| Linas Vepstas maintains | TrueAGI + SingularityNET |

## Key Differences

### Language

Classic:
```scheme
(InheritanceLink (ConceptNode "cat") (ConceptNode "animal"))
```

Hyperon / MeTTa:
```metta
(Inheritance "cat" "animal")
```

### Query

Classic:
```scheme
(cog-execute! (Get
    (InheritanceLink (VariableNode "$x") (ConceptNode "animal"))))
```

Hyperon / MeTTa:
```metta
!(bind $x (Inheritance $x "animal") $x)
```

### Execution

Classic:
```bash
# Build from source, start cogserver
cogserver -p 17001 -w 18080
telnet localhost 17001
```

Hyperon / MeTTa:
```bash
pip install hyperon
python3 -c "
from hyperon import *
m = MeTTa()
print(m.run('!(+ 1 2)'))
"
```

## Quick Start for Hyperon

```bash
pip install hyperon
```

Then run MeTTa interactively:
```bash
metta
!(+ 1 2)
! (Inheritance "cat" "animal")
!(bind $x (Inheritance $x "animal") $x)
```

## Coexistence

There is no reason to choose one exclusively. You can:

1. Use **Classic** for stable, production knowledge graph workloads
2. Use **Hyperon** for cutting-edge AGI research and neuro-symbolic AI
3. Bridge them via the CogServer WebSocket API

Example bridge:
```python
# Run MeTTa locally
from hyperon import *
m = MeTTa()
result = m.run('!(+ 1 2)')

# Store result in Classic AtomSpace via WebSocket
import asyncio, json, websockets
async def store(val):
    expr = f'(Concept "metta-result") (Evaluation (Predicate "value") (List (Concept "metta-result") (Number {val})))'
    async with websockets.connect("ws://localhost:18080/json") as ws:
        await ws.send(json.dumps({"command": "scheme", "body": expr}))
asyncio.run(store(result[0]))
```

## Resources

- MeTTa Tutorials: https://metta-lang.dev/docs/learn/learn.html
- Hyperon GitHub: https://github.com/trueagi-io/hyperon-wasm
- Hyperon PyPI: https://pypi.org/project/hyperon/
- OpenCog Wiki: https://wiki.opencog.org
- arXiv paper: https://arxiv.org/abs/2310.18318
