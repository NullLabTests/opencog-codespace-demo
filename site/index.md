---
layout: default
title: OpenCog AtomSpace Demo
---

# OpenCog AtomSpace Demo

A self-contained demonstration of the **OpenCog Classic** stack —
[AtomSpace](https://github.com/opencog/atomspace) +
[CogServer](https://github.com/opencog/cogserver) +
[Visualizer](https://github.com/opencog/atomspace-viz).

## Quick Start

```bash
# Docker (easiest)
docker compose up -d
telnet localhost 17001
```

```scheme
;; Create your first atoms
(Concept "hello-world")
(Inheritance (Concept "cat") (Concept "animal"))
```

## Documentation

- [Getting Started](../docs/getting-started.md)
- [Atomese Primer](../docs/atomese-primer.md)
- [Architecture](../docs/architecture.md)
- [Demo Scripts](../demo)
- [API Reference](../docs/api.md)

## Community

- [GitHub Repository](https://github.com/NullLabTests/opencog-codespace-demo)
- [OpenCog Discord](https://discord.gg/vxPc6sz)
- [OpenCog Wiki](https://wiki.opencog.org)
