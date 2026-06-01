# Best Practices for Knowledge Representation in Atomese

## Naming Conventions

### Atoms

| Convention | Example | When to Use |
|---|---|---|
| `kebab-case` | `(Concept "my-concept")` | General concepts, entities |
| `PascalCase` | `(Predicate "HasColor")` | Predicates and relations (optional) |
| `prefixed-$` | `(Variable "$my-var")` | Variables (always `$` prefix) |
| `lowercase` | `(Concept "cat")` | Common nouns |
| `number` | `(Number 42)` | Numeric values |

### File Organization

- One knowledge domain per file
- Clear section headers with `;; ── Domain Name ──`
- Comments explaining non-obvious patterns

## Ontology Design

### Prefer Inheritance over Duplication

```scheme
;; Good
(Inheritance (Concept "poodle") (Concept "dog"))
(Inheritance (Concept "dog")    (Concept "mammal"))

;; Avoid (duplicates knowledge)
(Evaluation (Predicate "is-mammal") (List (Concept "poodle") (Concept "true")))
(Evaluation (Predicate "is-mammal") (List (Concept "dog")    (Concept "true")))
```

### Use Inheritance for IS-A, Evaluation for Properties

```scheme
;; IS-A: Inheritance
(Inheritance (Concept "poodle") (Concept "dog"))

;; Properties: Evaluation
(Evaluation (Predicate "color") (List (Concept "poodle") (Concept "white")))
```

### Keep Type Hierarchy Shallow

A depth of 3–5 levels is usually sufficient:
```
domestic-cat → felis → felidae → carnivore → mammal → animal
```

## Query Patterns

### Minimal Variable Scope

```scheme
;; Good — only the variable you need
(Get (Inheritance (Variable "$x") (Concept "animal")))

;; Avoid — unnecessarily broad
(Get (Inheritance (Variable "$x") (Variable "$y")))
```

### Use AndLink for Compound Queries

```scheme
(Get
    (And (Inheritance (Variable "$x") (Concept "mammal"))
         (Evaluation (Predicate "color") (List (Variable "$x") (Concept "brown")))))
```

## Script Structure

Every demo script should follow this template:

```scheme
;; ── Header ──
;; Description: what this script does
;; Usage: cat script.scm | nc localhost 17001

;; ── Step 1: Create Concepts ──
(Concept "foo")

;; ── Step 2: Create Relationships ──
(Inheritance (Concept "foo") (Concept "bar"))

;; ── Step 3: Query ──
(cog-execute! (Get ...))
```

## Performance Tips

| Practice | Reason |
|---|---|
| Prefer `(Concept "x")` over `(ConceptNode "x")` | Shorter, equivalent |
| Batch atom creation in a single script | Avoids per-command overhead |
| Use type filters in queries | `(cog-count-atoms 'ConceptNode)` is faster unfiltered but filtered gives specific counts |
| Avoid deleting atoms in loops | Deleting triggers index updates |
| Use `(cog-atomspace)` sparingly | Lists every atom — expensive for large spaces |
