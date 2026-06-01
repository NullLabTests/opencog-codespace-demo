# Getting Involved with OpenCog

The OpenCog project welcomes contributors at all levels. Here's how to
get started.

## Quick Start

1. **Join the [Discord](https://discord.gg/vxPc6sz)** — this is where
   daily development discussion happens. Introduce yourself in #general.
2. **Read the [Wiki](https://wiki.opencog.org)** — understand the concepts,
   architecture, and terminology.
3. **Try this demo repo** — get familiar with the AtomSpace by running the
   demo scripts and exploring the visualizer.

## Choose Your Track

### 🧠 OpenCog Classic (this stack)

The stable C++ stack. Good for:
- Knowledge representation experiments
- Building on a proven, documented codebase
- NLP with Link Grammar
- Understanding the foundation before moving to Hyperon

**Contact:** Linas Vepstas (linasvepstas@gmail.com) for developer onboarding

**Repos to watch:**
- https://github.com/opencog/atomspace
- https://github.com/opencog/cogserver
- https://github.com/opencog/link-grammar

### 🚀 OpenCog Hyperon / MeTTa (next generation)

The successor architecture. Good for:
- Cutting-edge AGI research
- Neuro-symbolic AI with LLM integration
- Distributed knowledge graphs
- Rust and Python development

**Repos to watch:**
- https://github.com/trueagi-io/hyperon-wasm
- https://github.com/trueagi-io/meTTa
- https://github.com/trueagi-io/chaining

### 🤖 SingularityNET / ASI Alliance

The decentralized AI platform that backs OpenCog Hyperon.

**Explore:**
- https://singularitynet.io
- https://asi-alliance.org
- https://deepfunding.ai (grants for AGI research)

## Getting Started with Code

### For Classic (C++):
```bash
git clone https://github.com/opencog/atomspace.git
cd atomspace
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DHAVE_GUILE
make -j$(nproc)
```

### For Hyperon (Python):
```bash
pip install hyperon
python -c "from hyperon import *; print(MeTTa().run('!(+ 1 2)'))"
```

## Learning Resources

| Resource | Link |
|---|---|
| OpenCog Wiki | https://wiki.opencog.org |
| MeTTa Tutorials | https://metta-lang.dev/docs/learn/learn.html |
| arXiv paper (2023) | https://arxiv.org/abs/2310.18318 |
| Ben Goertzel's blog | https://goertzel.org |
| AGI Discussion Forum | https://groups.google.com/g/opencog |
