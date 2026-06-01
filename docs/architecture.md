# Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                         Browser (HTTP / WSS)                        │
│  ┌──────────────┐  ┌───────────────┐  ┌──────────┐  ┌────────────┐ │
│  │  Visualizer  │  │ WebSocket     │  │ Stats    │  │ JSON Test  │ │
│  │  (landing.js)│  │ Shell         │  │ Dashboard│  │ Page       │ │
│  └──────┬───────┘  └──────┬────────┘  └─────┬────┘  └──────┬─────┘ │
└─────────┼──────────────────┼─────────────────┼───────────────┼───────┘
          │ ws://:18080      │ ws://:18080      │ http://:18080        
          ▼                  ▼                 ▼               ▼
┌─────────────────────────────────────────────────────────────────────┐
│                         CogServer (:18080)                          │
│                                                                     │
│  ┌────────────────┐  ┌────────────────┐  ┌──────────────────────┐  │
│  │  JSON Shell    │  │  Scheme Shell  │  │  Python Shell        │  │
│  │  (WebSocket)   │  │  (WebSocket)   │  │  (WebSocket)         │  │
│  ├────────────────┤  ├────────────────┤  ├──────────────────────┤  │
│  │  S-Expr Shell  │  │  Top Shell     │  │  BuiltinReq Module   │  │
│  │  (telnet)      │  │  (admin)       │  │  (HTTP /stats etc.)  │  │
│  └────────────────┘  └────────────────┘  └──────────────────────┘  │
│                           │                                         │
└───────────────────────────┼─────────────────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────────────────┐
│                         AtomSpace Core                               │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                  Atom Table (in-RAM)                         │   │
│  │  ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌──────────┐ │   │
│  │  │ Concept   │  │ Inherit-  │  │ Evalu-   │  │ Variable │ │   │
│  │  │ Nodes     │  │ anceLinks │  │ ationLinks│  │ Nodes    │ │   │
│  │  └───────────┘  └───────────┘  └───────────┘  └──────────┘ │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                  Query Engine                               │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐   │   │
│  │  │ Pattern      │  │ Graph        │  │ Value            │   │   │
│  │  │ Matcher      │  │ Rewriter     │  │ System           │   │   │
│  │  └──────────────┘  └──────────────┘  └──────────────────┘   │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                  Type System                                │   │
│  │  60+ built-in atom types, extensible, single-inheritance    │   │
│  └──────────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────────────────┐
│                      Storage Backends                               │
│                                                                      │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────────────┐ │
│  │  RocksDB       │  │  PostgreSQL    │  │  CogServer Network     │ │
│  │  (local disk)  │  │  (remote DB)   │  │  (distributed)         │ │
│  └────────────────┘  └────────────────┘  └────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────┘
```

## Component Breakdown

### 1. CogServer — The Network Layer

The network front-end listens on three ports simultaneously:

| Port | Protocol | Purpose |
|---|---|---|
| 17001 | Telnet / TCP | Scheme REPL shell |
| 18080 | HTTP + WebSocket | Web UI, visualizer, JSON API, stats dashboard |
| 18888 | MCP | Model Context Protocol agent interface |

Loaded modules (visible at `/stats`):
- **SchemeShellModule** — GNU Guile REPL
- **PythonShellModule** — Python interpreter
- **JsonShellModule** — JSON-over-WebSocket command layer
- **SexprShellModule** — S-expression shell
- **BuiltinRequestsModule** — HTTP handlers (stats, favicon, etc.)
- **TopShellModule** — Server management (shutdown, module listing)

### 2. AtomSpace Core (`libatomspace`)

The in-memory metagraph database:

| Component | Description |
|---|---|
| **Atom Table** | Concurrent hash map of every atom, keyed by UUID |
| **Indexes** | Type index, name index, incoming-set and outgoing-set indexes |
| **Type System** | 60+ built-in atom types in a single-inheritance hierarchy |
| **Pattern Matcher** | Subgraph isomorphism engine with variable support |
| **Graph Rewriter** | BindLink-driven pattern → rewrite rule engine |
| **Value System** | Extensible key-value store per atom (floats, strings, vectors, etc.) |
| **Truth Values** | Probabilistic truth with strength (0–1) and confidence (0–1) |

### 3. Storage Backends

Persistence through the `StorageNode` abstraction:

- **RocksDBStorageNode** — local disk via RocksDB
- **PostgreSQLStorageNode** — remote database persistence
- **CogStorageNode** — distributed, network-backed storage

## Request Flow

```
User sends Atomese command
        │
        ▼
Shell (SchemeShell / JsonShell) parses the text
        │
        ▼
AtomSpace executes the operation (create atom, run query, etc.)
        │
        ▼
Result serializes back to text or JSON
        │
        ▼
Response delivered over WebSocket or TCP
```

## Concurrency

The CogServer uses a thread pool for concurrent connections. Each shell
runs on its own thread. The AtomSpace uses read-write locks — concurrent
reads are safe while writes are serialized.

## Memory Model

Atoms are reference-counted and garbage-collected. The AtomSpace holds a
global dictionary of all live atoms. Once all external references to an
atom are dropped it is removed from the atomspace and freed.
