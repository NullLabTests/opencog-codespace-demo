# Atomese — The Language of the AtomSpace

Atomese is the native query and manipulation language for the OpenCog
AtomSpace. It is embedded in GNU Guile Scheme, so every Scheme expression
is valid Atomese and every atom is a first-class Scheme value.

## Core Concepts

### Atoms

An **atom** is the fundamental unit of knowledge. Each atom carries:

- A **type** — determines its role in the knowledge graph
- A **name** — optional, used for named nodes such as `ConceptNode`
- A **value** — optional; can hold numbers, vectors, strings, or arbitrary data
- A **truth value** — optional; represents strength and confidence

### Types of Nodes

| Type | Example | Purpose |
|---|---|---|
| `ConceptNode` | `(ConceptNode "dog")` | A concept or entity |
| `PredicateNode` | `(PredicateNode "likes")` | A relation or property |
| `VariableNode` | `(VariableNode "$x")` | Variable placeholder in queries |
| `NumberNode` | `(NumberNode 42)` | Numeric literal |
| `WordNode` | `(WordNode "hello")` | NLP token |
| `TypeNode` | `(TypeNode "ConceptNode")` | Reference to an atom type |

### Links (Edges)

A **link** connects atoms to form the graph:

| Link Type | Example | Meaning |
|---|---|---|
| `InheritanceLink` | `(InheritanceLink A B)` | A **is-a** B |
| `EvaluationLink` | `(EvaluationLink P (List A B))` | Predicate P holds for (A, B) |
| `ListLink` | `(ListLink A B C)` | Ordered sequence |
| `GetLink` | `(GetLink pattern)` | Query the atomspace |
| `BindLink` | `(BindLink pattern rewrite)` | Query + graph rewrite |
| `AndLink` / `OrLink` / `NotLink` | — | Boolean combinators |
| `PlusLink` / `TimesLink` | — | Arithmetic operators |

## Pattern Matching

The AtomSpace's pattern matcher finds every subgraph that matches a
template containing variables:

```scheme
;; Find every creature that is an animal
(Get
    (InheritanceLink
        (VariableNode "$creature")
        (ConceptNode "animal")))
```

## Graph Rewriting

`BindLink` pairs a pattern with a rewrite rule — when the pattern
matches, the rewrite is instantiated:

```scheme
;; For every X that inherits from "animal", also make it inherit
;; from "living-thing"
(BindLink
    (InheritanceLink
        (VariableNode "$X")
        (ConceptNode "animal"))
    (InheritanceLink
        (VariableNode "$X")
        (ConceptNode "living-thing")))
```

## Truth Values

Every atom can hold a **SimpleTruthValue** with two components:

- **Strength** — degree of belief (0.0–1.0)
- **Confidence** — certainty of that belief (0.0–1.0)

```scheme
;; Create an atom with specific truth value: 90% strength, 80% confidence
(cog-new-link
    'InheritanceLink
    (ConceptNode "cat")
    (ConceptNode "animal")
    (cog-new-stv 0.9 0.8))
```

## Arbitrary Values

Atoms can hold arbitrary key-value data:

```scheme
;; Float
(cog-set-value! (ConceptNode "sensor")
    (PredicateNode "temperature")
    (FloatValue 22.5))

;; String
(cog-set-value! (ConceptNode "greeting")
    (PredicateNode "text")
    (StringValue "Hello, world!"))

;; Read back
(cog-value (ConceptNode "sensor") (PredicateNode "temperature"))
```

## Python Bindings

The AtomSpace also exposes a Python API:

```python
from opencog import *

cat = ConceptNode("cat")
animal = ConceptNode("animal")
InheritanceLink(cat, animal)

result = cog_execute(
    Get(InheritanceLink(VariableNode("$x"), ConceptNode("animal"))))
```

## Common Knowledge Patterns

### Taxonomy / Class Hierarchy
```scheme
(InheritanceLink (ConceptNode "poodle")   (ConceptNode "dog"))
(InheritanceLink (ConceptNode "dog")      (ConceptNode "mammal"))
(InheritanceLink (ConceptNode "mammal")   (ConceptNode "animal"))
```

### Property / Attribute
```scheme
(EvaluationLink
    (PredicateNode "has-color")
    (ListLink (ConceptNode "sky") (ConceptNode "blue")))
```

### Membership
```scheme
(MemberLink (ConceptNode "alice")
            (ConceptNode "programmers"))
```

### Temporal
```scheme
(AtTimeLink
    (ConceptNode "meeting")
    (TimeNode "2026-06-01 17:00:00"))
```

## Reference Commands

| Expression | Purpose |
|---|---|
| `(cog-get-types)` | List all registered atom types |
| `(cog-count-atoms)` | Total atom / link counts |
| `(cog-atomspace)` | Enumerate every atom |
| `(cog-prt-atomspace)` | Pretty-print the atomspace |
| `(help)` | REPL help |
