# OpenCog Ecosystem

The AtomSpace sits at the center of a larger ecosystem of cognitive
AI projects. Together they form the **OpenCog Hyperon** (AGI architecture)
and its predecessor **OpenCog Classic**.

```
┌───────────────────────────────────────────────────────────────────┐
│                      OpenCog Ecosystem                            │
│                                                                   │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │                    Application Layer                       │   │
│  │  ┌──────────┐ ┌──────────┐ ┌───────────┐ ┌─────────────┐ │   │
│  │  │ MOSES    │ │ PLN      │ │ Pattern   │ │ Embodiment  │ │   │
│  │  │ (ML)     │ │ (Reason) │ │ Miner     │ │ (Robotics)  │ │   │
│  │  └──────────┘ └──────────┘ └───────────┘ └─────────────┘ │   │
│  └───────────────────────────────────────────────────────────┘   │
│                           │                                       │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │                   Core Platform                           │   │
│  │  ┌──────────────┐  ┌────────────────┐  ┌──────────────┐  │   │
│  │  │  AtomSpace   │  │   CogServer    │  │  cogutil     │  │   │
│  │  │  (database)  │  │   (network)    │  │  (utilities) │  │   │
│  │  └──────┬───────┘  └───────┬────────┘  └──────────────┘  │   │
│  └─────────┼──────────────────┼──────────────────────────────┘   │
│            │                  │                                    │
│  ┌─────────┴──────────────────┴──────────────────────────────┐   │
│  │                    Storage Layer                           │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │   │
│  │  │ RocksDB  │  │ PostgreSQL│  │ CogStorage│  │ In-Memory│  │   │
│  │  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │   │
│  └───────────────────────────────────────────────────────────┘   │
│                           │                                       │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │                    Hyperon (Next Gen)                     │   │
│  │  ┌──────────────┐  ┌────────────────┐  ┌──────────────┐  │   │
│  │  │ MeTTa        │  │  Combo         │  │  NLP         │  │   │
│  │  │ (language)   │  │  (program repr)│  │  (RelEx, etc)│  │   │
│  │  └──────────────┘  └────────────────┘  └──────────────┘  │   │
│  └───────────────────────────────────────────────────────────┘   │
└───────────────────────────────────────────────────────────────────┘
```

## Core Components

### AtomSpace (`atomspace`)
The in-memory knowledge graph database. Store, query, and rewrite
typed, directed hypergraphs. Written in C++ with bindings for Scheme
and Python. This is the foundational data structure that everything
else builds on.

**Repository:** https://github.com/opencog/atomspace

### CogServer (`cogserver`)
The network server that wraps the AtomSpace, providing:
- TCP REPL (Scheme, Python, S-expressions)
- WebSocket API (JSON, Scheme)
- HTTP stats dashboard
- Visualizer web UI
- Agent lifecycle management

**Repository:** https://github.com/opencog/cogserver

### cogutil
Shared utility library: threading, logging, serialization, timer,
file management. Used by every other OpenCog component.

**Repository:** https://github.com/opencog/cogutil

### atomspace-storage
Storage backend implementations for the AtomSpace:
- RocksDB (local, persistent)
- PostgreSQL (remote, multi-client)
- Distributed CogStorage (network sharding)

**Repository:** https://github.com/opencog/atomspace-storage

## Reasoning & Learning

| Project | Description | Language |
|---|---|---|
| **PLN** (Probabilistic Logic Networks) | Term-level probabilistic reasoner; inference rules with truth-value propagation | C++ / Scheme |
| **MOSES** (Meta-Optimizing Semantic Evolutionary Search) | Program evolution & optimization; learns compact Combo programs | C++ / Python |
| **Pattern Miner** | Frequent subgraph mining over the atomspace | C++ |
| **Rule Engine** | Forward/backward chaining over Atomese rules | C++ |
| **Openpsi** | Micro-architecture for online learning & decision-making in agents | C++ |

## Language / NLP

| Project | Description |
|---|---|
| **RelEx** | Dependency-relation extractor; parses English into Atomese |
| **Link Grammar** | Parsing English and other natural languages into syntactic relations |
| **ConceptNet** | Large commonsense knowledge base importable into the atomspace |
| **NLGen** | Natural language generation from semantic representations |
| **Relex2Logic** | Translates RelEx output into PLN-compatible logical forms |

## Robotics & Embodiment

| Project | Description |
|---|---|
| **OpenCog Embodiment** | Embodied agent framework; connects to real and simulated environments |
| **Extendible AI** | Bridge between AtomSpace and ROS (Robot Operating System) |
| **Virtual World** | 3D simulation environment for training embodied agents |

## Community

| Channel | Link | Purpose |
|---|---|---|
| **Discord** | https://discord.gg/vxPc6sz | Daily chat — most active community hub |
| **GitHub** | https://github.com/opencog | 90+ repos, 500+ followers — all source code |
| **Wiki** | https://wiki.opencog.org | Documentation, tutorials, concepts |
| **Mailing List** | opencog@googlegroups.com | Long-form discussion, announcements |
| **Blog** | https://blog.opencog.org | Project updates, research posts |
| **Reddit** | https://reddit.com/r/opencog | Community discussion |

### Key People

| Person | Role |
|---|---|
| **Ben Goertzel** | Founder, original architect; CEO of SingularityNET & ASI Alliance |
| **Linas Vepstas** | Primary maintainer of OpenCog Classic (AtomSpace, Link Grammar) |
| **Vitaly Bogdanov** | AtomSpace, CogServer, storage backends |
| **Nil Geisweiller** | PLN, pattern miner, learning algorithms |
| **Zarathustra Goertzel** | Hyperon / MeTTa, distributed systems |
| **Matthew Ikle'** | PLN, probabilistic reasoning |
| **Lucius Greg Meredith** | MeTTa language design, process algebra |

Full credits in [CONTRIBUTORS.md](/CONTRIBUTORS.md).

## Next Generation: Hyperon

The **OpenCog Hyperon** project is the next-generation architecture
that builds on lessons from OpenCog Classic:

| Project | Description |
|---|---|
| **MeTTa** | A new programming language designed for cognitive AI — unifies logic, functional, and probabilistic programming |
| **Hyperon Core** | The new metagraph database and cognitive architecture |
| **MeTTa-LLM** | Integration between MeTTa and Large Language Models for neuro-symbolic AI |

**Repository:** https://github.com/trueagi-io/hyperon-wasm

## How This Demo Repo Fits In

This demo installs **OpenCog Classic** — the stable, battle-tested
stack consisting of:

1. `cogutil` — shared utilities
2. `atomspace` — knowledge graph core + storage backends
3. `cogserver` — server + web UI + visualizer
4. `atomspace-viz` — web-based graph visualizer

You interact with the AtomSpace through the CogServer via Telnet,
WebSocket, or the browser-based visualizer. All components are compiled
from source on Ubuntu 24.04 with GCC 14.
