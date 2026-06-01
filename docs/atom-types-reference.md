# Atom Types Reference

Every atom in the AtomSpace has a **type** that determines its role in
the knowledge graph. The type system has 60+ built-in types in a
single-inheritance hierarchy.

## Type Hierarchy (Top Levels)

```
Atom
├── Node                  # Named entities (no outgoing set)
│   ├── ConceptNode       # General concepts
│   ├── PredicateNode     # Relations and properties
│   ├── VariableNode      # Query variables ($-prefixed)
│   ├── NumberNode        # Numeric literals
│   ├── WordNode          # NLP word tokens
│   ├── TypeNode          # Type references (metatype)
│   ├── TimeNode          # Time points
│   ├── AnchorNode        # Named anchor points
│   └── SchemaNode        # Executable schema references
│
└── Link                  # Connections between atoms
    ├── InheritanceLink   # IS-A relationship (2 args)
    ├── SimilarityLink    # Similarity (2 args)
    ├── MemberLink        # Set membership (2 args)
    ├── PartOfLink        # Mereological part-whole (2 args)
    ├── AssociativeLink   # Weak association (2 args)
    ├── EvaluationLink    # Predicate application (2+ args)
    ├── ListLink          # Ordered sequence (1+ args)
    ├── SetLink           # Unordered set (1+ args)
    ├── AndLink           # Logical AND
    ├── OrLink            # Logical OR
    ├── NotLink           # Logical NOT
    ├── ImplicationLink   # If-then rule (2 args)
    ├── EquivalenceLink   # Iff (2 args)
    ├── ForAllLink        # Universal quantifier
    ├── ThereExistsLink   # Existential quantifier
    ├── GetLink           # Pattern query (1 arg)
    ├── BindLink          # Query + rewrite (2 args)
    ├── MeetLink          # Satisfying-set query
    ├── PlusLink          # Numeric addition
    ├── TimesLink         # Numeric multiplication
    ├── GreaterThanLink   # Numeric comparison
    ├── EqualLink         # Numeric equality
    ├── ExecutionLink     # Grounded function call (3 args)
    ├── AtTimeLink        # Temporal anchoring (2 args)
    ├── PropertyLink      # Property assignment (2 args)
    └── BeforeLink        # Temporal ordering (2 args)
```

## Common Patterns by Type

### Knowledge Organization
```scheme
(Inheritance (Concept "cat") (Concept "animal"))       ;; IS-A
(Member (Concept "alice") (Concept "programmers"))       ;; Membership
(PartOf (Concept "wheel") (Concept "car"))              ;; Part-Whole
(Similarity (Concept "car") (Concept "truck"))          ;; Similarity
```

### Properties & Relations
```scheme
(Evaluation (Predicate "color") (List (Concept "sky") (Concept "blue")))
(Associative (Concept "rain") (Concept "umbrella"))
```

### Logic
```scheme
(And (Concept "a") (Concept "b"))
(Or  (Concept "a") (Concept "b"))
(Not (Concept "false"))
(Implication (Concept "rain") (Concept "wet-ground"))
```

### Queries
```scheme
(Get (Inheritance (Variable "$x") (Concept "animal")))
(Bind
    (Inheritance (Variable "$x") (Concept "animal"))
    (Inheritance (Variable "$x") (Concept "living-thing")))
```

### Arithmetic
```scheme
(Plus (Number 1) (Number 2))
(Times (Number 6) (Number 7))
(GreaterThan (Number 100) (Number 42))
(Equal (Number 42) (Number 42))
```

### Temporal
```scheme
(AtTime (Concept "meeting") (Time "2026-06-01T17:00:00"))
(Before (Time "09:00") (Time "10:00"))
```

## Type Introspection

```scheme
;; List all registered types
(cog-get-types)

;; Get type of a specific atom
(cog-type (ConceptNode "test"))

;; Get parent type
(cog-type (TypeNode "ConceptNode"))

;; Check if atom is a node or link
(cog-node? (ConceptNode "test"))
(cog-link? (InheritanceLink ...))
```
