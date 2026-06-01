# AtomSpace Vocabulary Reference — Quick Glance

## Node Types

| Type | Pattern | Description |
|---|---|---|
| `ConceptNode` | `(Concept "name")` | Named concept / entity |
| `PredicateNode` | `(Predicate "name")` | Relation or property |
| `VariableNode` | `(Variable "$name")` | Query variable |
| `NumberNode` | `(Number 42)` | Numeric literal |
| `WordNode` | `(Word "hello")` | NLP word token |
| `TypeNode` | `(Type "ConceptNode")` | Type reference |
| `TimeNode` | `(Time "2026-01-01")` | Time point |
| `AnchorNode` | `(Anchor "name")` | Named anchor point |
| `SchemaNode` | `(Schema "add-numbers")` | Executable schema |

## Link Types

| Type | Arity | Purpose |
|---|---|---|
| `InheritanceLink` | 2 | X is-a Y |
| `SimilarityLink` | 2 | X is similar to Y |
| `MemberLink` | 2 | X is a member of set Y |
| `PartOfLink` | 2 | X is part of Y |
| `AssociativeLink` | 2 | X is associated with Y |
| `EvaluationLink` | 2+ | Predicate(subject, object, ...) |
| `ListLink` | 1+ | Ordered sequence |
| `SetLink` | 1+ | Unordered set |
| `AndLink` | 1+ | Logical AND |
| `OrLink` | 1+ | Logical OR |
| `NotLink` | 1 | Logical NOT |
| `ImplicationLink` | 2 | If P then Q |
| `EquivalenceLink` | 2 | P iff Q |
| `ForAllLink` | 2 | Universal quantifier |
| `ThereExistsLink` | 2 | Existential quantifier |
| `GetLink` | 1 | Pattern query |
| `BindLink` | 2 | Query + rewrite |
| `MeetLink` | 1 | Satisfying-set query |
| `PlusLink` | 2+ | Numeric addition |
| `TimesLink` | 2+ | Numeric multiplication |
| `GreaterThanLink` | 2 | Numeric comparison |
| `EqualLink` | 2 | Numeric equality |
| `ExecutionLink` | 3 | Execute GroundedSchema |
| `AtTimeLink` | 2 | Event at time |
| `PropertyLink` | 2 | Has property |

## Common Scheme Functions

| Function | Purpose |
|---|---|
| `(cog-new-node type name)` | Create or fetch a node |
| `(cog-new-link type . args)` | Create a link |
| `(cog-node type name)` | Fetch existing node |
| `(cog-link type . args)` | Fetch existing link |
| `(cog-atom atom)` | Test if atom exists |
| `(cog-delete atom)` | Delete an atom |
| `(cog-delete-recursive atom)` | Delete atom + all links to it |
| `(cog-atomspace)` | List all atoms |
| `(cog-prt-atomspace)` | Pretty-print all atoms |
| `(cog-count-atoms)` | Count atoms and links |
| `(cog-count-nodes)` | Count only nodes |
| `(cog-count-links)` | Count only links |
| `(cog-get-types)` | List all atom types |
| `(cog-type atom)` | Get type of an atom |
| `(cog-name atom)` | Get name of an atom |
| `(cog-arity link)` | Get outgoing-set size |
| `(cog-outgoing-set link)` | Get children |
| `(cog-incoming-set atom)` | Get parents |
| `(cog-tv atom)` | Get truth value |
| `(cog-set-tv! atom tv)` | Set truth value |
| `(cog-new-stv s c)` | Create SimpleTruthValue (strength, confidence) |
| `(cog-set-value! atom key value)` | Attach arbitrary value |
| `(cog-value atom key)` | Retrieve arbitrary value |
| `(cog-evaluate! expr)` | Evaluate an expression |
| `(cog-execute! expr)` | Execute a ground or query |
| `(cog-chase-link type pred target)` | Follow links of a type |
| `(cog-map type func)` | Map over atoms of a type |

## Truth Values

| TV Type | Constructor | Meaning |
|---|---|---|
| SimpleTruthValue | `(cog-new-stv s c)` | Strength (0-1) + Confidence (0-1) |
| CountTruthValue | `(cog-new-ctv s c count)` | As STV + count |
| IndefiniteTruthValue | `(cog-new-itv l u s c)` | Interval [l, u] + strength + confidence |
| FuzzyTruthValue | `(cog-new-ftv f)` | Single fuzzy value |
| NullTruthValue | `(stv 1 0)` | Default / unknown |

## API Ports

| Port | Protocol | Use |
|---|---|---|
| 17001 | TCP (telnet) | Scheme REPL |
| 18080 | HTTP + WS | Web UI + visualizer |
| 18888 | MCP | Model Context Protocol |
