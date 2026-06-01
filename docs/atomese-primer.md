# Atomese — The Language of the AtomSpace

Atomese is the native query and manipulation language for the OpenCog
AtomSpace. It is embedded in GNU Guile Scheme, so every Scheme expression
is valid Atomese and every atom is a first-class Scheme value.

## Core Concepts

### Atoms

An **atom** is the fundamental unit of knowledge. Each atom carries:

- A **type** — determines its role in the knowledge graph
- A **name** — optional, used for named nodes such as `Concept`
- A **value** — optional; can hold numbers, vectors, strings, or arbitrary data
- A **truth value** — optional; represents strength and confidence

### Types of Nodes

| Type | Example | Purpose |
|---|---|---|
| `ConceptNode` | `(Concept "dog")` | A concept or entity |
| `PredicateNode` | `(Predicate "likes")` | A relation or property |
| `VariableNode` | `(Variable "$x")` | Variable placeholder in queries |
| `NumberNode` | `(Number 42)` | Numeric literal |
| `WordNode` | `(Word "hello")` | NLP token |
| `TypeNode` | `(Type "ConceptNode")` | Reference to an atom type |

### Links (Edges)

A **link** connects atoms to form the graph:

| Link Type | Example | Meaning |
|---|---|---|
| `InheritanceLink` | `(Inheritance A B)` | A **is-a** B |
| `EvaluationLink` | `(Evaluation P (List A B))` | Predicate P holds for (A, B) |
| `ListLink` | `(List A B C)` | Ordered sequence |
| `GetLink` | `(Get pattern)` | Query the atomspace |
| `BindLink` | `(Bind pattern rewrite)` | Query + graph rewrite |
| `AndLink` / `OrLink` / `NotLink` | — | Boolean combinators |
| `PlusLink` / `TimesLink` | — | Arithmetic operators |

## Pattern Matching

The AtomSpace's pattern matcher finds every subgraph that matches a
template containing variables:

```scheme
;; Find every creature that is an animal
(Get
    (Inheritance
        (Variable "$creature")
        (Concept "animal")))
```

## Graph Rewriting

`BindLink` pairs a pattern with a rewrite rule — when the pattern
matches, the rewrite is instantiated:

```scheme
;; For every X that inherits from "animal", also make it inherit
;; from "living-thing"
(Bind
    (Inheritance
        (Variable "$X")
        (Concept "animal"))
    (Inheritance
        (Variable "$X")
        (Concept "living-thing")))
```

## Truth Values

Every atom can hold a **SimpleTruthValue** with two components:

- **Strength** — degree of belief (0.0–1.0)
- **Confidence** — certainty of that belief (0.0–1.0)

```scheme
;; Create an atom with specific truth value: 90% strength, 80% confidence
(cog-new-link
    'InheritanceLink
    (Concept "cat")
    (Concept "animal")
    (cog-new-stv 0.9 0.8))
```

## Arbitrary Values

Atoms can hold arbitrary key-value data:

```scheme
;; Float
(cog-set-value! (Concept "sensor")
    (Predicate "temperature")
    (FloatValue 22.5))

;; String
(cog-set-value! (Concept "greeting")
    (Predicate "text")
    (StringValue "Hello, world!"))

;; Read back
(cog-value (Concept "sensor") (Predicate "temperature"))
```

## Python Bindings

The AtomSpace also exposes a Python API:

```python
from opencog import *

cat = Concept("cat")
animal = Concept("animal")
Inheritance(cat, animal)

result = cog_execute(
    Get(Inheritance(Variable("$x"), Concept("animal"))))
```

## Common Knowledge Patterns

### Taxonomy / Class Hierarchy
```scheme
(Inheritance (Concept "poodle")   (Concept "dog"))
(Inheritance (Concept "dog")      (Concept "mammal"))
(Inheritance (Concept "mammal")   (Concept "animal"))
```

### Property / Attribute
```scheme
(Evaluation
    (Predicate "has-color")
    (List (Concept "sky") (Concept "blue")))
```

### Membership
```scheme
(Member (Concept "alice")
        (Concept "programmers"))
```

### Temporal
```scheme
(AtTime
    (Concept "meeting")
    (Time "2026-06-01 17:00:00"))
```

## Reference Commands

| Expression | Purpose |
|---|---|
| `(cog-get-types)` | List all registered atom types |
| `(cog-count-atoms)` | Total atom / link counts |
| `(cog-atomspace)` | Enumerate every atom |
| `(cog-prt-atomspace)` | Pretty-print the atomspace |
| `(help)` | REPL help |
