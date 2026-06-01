# Getting Started with OpenCog AtomSpace

## Prerequisites

A running CogServer instance. By default it listens on:
- Port `17001` — Telnet / raw TCP for the Scheme REPL
- Port `18080` — HTTP + WebSocket for the web UI, visualizer, and JSON API

## Method 1: WebSocket Shell (Browser)

Open the WebSocket Shell in your browser:

```
http://<host>:18080/websockets/demo.html
```

Click **Connect** (defaults to `ws://<host>:18080/`). Type Atomese
commands in the input box and click **Send**.

## Method 2: Telnet REPL

```bash
telnet localhost 17001
```

You will see the `opencog>` prompt. Type Scheme expressions directly:

```scheme
(use-modules (opencog))
(Concept "hello")
```

## Method 3: Piped Scripts

Batch-load a file of Atomese expressions:

```bash
cat demo/comprehensive-demo.scm | nc localhost 17001
```

## Your First Atoms

The AtomSpace stores knowledge as **atoms** (nodes) held together by
**links** (edges). Every atom has a **type** that defines what it is and
how the system may use it.

### Creating Nodes

```scheme
(Concept "apple")
(Concept "fruit")
(Concept "red")
```

### Creating Links

```scheme
;; apple IS-A fruit
(Inheritance (Concept "apple") (Concept "fruit"))

;; apple HAS-PROPERTY red
(Property (Concept "apple") (Concept "red"))

;; predicate-style: likes(cat, milk)
(Evaluation
    (Predicate "likes")
    (List
        (Concept "cat")
        (Concept "milk")))
```

### Querying

```scheme
;; Find everything that inherits from "fruit"
(cog-execute!
    (Get
        (Inheritance
            (Variable "$what")
            (Concept "fruit"))))

;; Dump every atom in the atomspace
(cog-execute! (Get (Any (Variable "$x"))))
```

### Numeric Evaluation

```scheme
(cog-evaluate! (Plus (Number 1) (Number 2)))         → (Number 3)
(cog-evaluate! (GreaterThan (Number 10) (Number 5)))  → (True)
```

## Next Steps

- Read the [Atomese Primer](atomese-primer.md) for a deep tour of the language
- Check the [Architecture](architecture.md) to understand how all components fit
- Try the [Demo Scripts](../README.md#demo-scripts) in this repo for hands-on examples
