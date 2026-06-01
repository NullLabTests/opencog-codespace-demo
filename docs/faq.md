# FAQ — Frequently Asked Questions

## General

### What is the OpenCog AtomSpace?
An in-memory hypergraph knowledge representation database. It stores
knowledge as typed, directed atoms (nodes) connected by links (edges).
Unlike traditional graph databases, links can point to other links,
creating a metagraph.

### Is this the same as OpenCog Hyperon / MeTTa?
No. This repo demonstrates **OpenCog Classic** (the original C++ stack).
**Hyperon / MeTTa** is the successor architecture under active development
at TrueAGI. Both projects share the same lineage and vision. See
[docs/ecosystem.md](docs/ecosystem.md) for the full map.

### Is the AtomSpace production-ready?
Yes. It has been in development since 2008, is actively maintained by
Linas Vepstas, and has been deployed in research and commercial contexts
including Hanson Robotics' Sophia robot and SingularityNET infrastructure.

## Using the Demo

### How do I connect?
Three ways:
1. **Telnet:** `telnet localhost 17001`
2. **WebSocket Shell:** `http://localhost:18080/websockets/demo.html`
3. **Piped script:** `cat script.scm | nc localhost 17001`

### What can I do with it?
Create atoms, build knowledge graphs, run pattern-matching queries,
perform graph rewriting, evaluate arithmetic, attach truth values,
and more. See the [demo scripts](/demo) for examples.

### How do I clear the atomspace?
```scheme
(cog-delete-recursive (ConceptNode "whatever"))
```
Or, for a full reset, restart the CogServer.

## Technical

### What ports does the CogServer use?
| Port | Purpose |
|---|---|
| 17001 | Scheme REPL (telnet/TCP) |
| 18080 | Web UI + WebSocket + HTTP API |
| 18888 | MCP (Model Context Protocol) |

### What language are the REPL commands?
**Scheme** (GNU Guile). Atomese is embedded in Scheme, so every Scheme
expression is valid, and every atom is a first-class Scheme value.
Python and JSON shells are also available.

### Can I persist data?
Yes. The AtomSpace supports RocksDB and PostgreSQL backends. See the
[Advanced Usage](/README.md#advanced-usage) section in the README.

### What are the system requirements?
- **Build:** Ubuntu 24.04, GCC 14, CMake 3.28, 4 GB RAM, 4 cores (~12 min)
- **Run:** Any Linux with glibc 2.39+, 256 MB RAM (minimal atomspace)
- **Docker:** Any system with Docker Engine 24+

## Community

### Where is the OpenCog community?
- **Discord:** https://discord.gg/vxPc6sz
- **GitHub:** https://github.com/opencog
- **Wiki:** https://wiki.opencog.org
- **Reddit:** https://reddit.com/r/opencog

### How do I contribute to this repo?
See [CONTRIBUTING.md](CONTRIBUTING.md).

### How do I contribute to the OpenCog project itself?
1. Join the [Discord](https://discord.gg/vxPc6sz)
2. Browse open issues on the relevant repo
3. Submit PRs with your changes
4. Contact Linas Vepstas (linasvepstas@gmail.com) for developer onboarding

### Where can I learn more about AGI and OpenCog?
- **OpenCog Wiki:** https://wiki.opencog.org
- **Hyperon Tutorials:** https://metta-lang.dev/docs/learn/learn.html
- **arXiv paper (2023):** https://arxiv.org/abs/2310.18318
- **Ben Goertzel's blog:** https://goertzel.org

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues.
