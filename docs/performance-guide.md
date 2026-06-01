# Performance Guide — OpenCog AtomSpace

## Atom Creation

- **Throughput:** ~500,000 atoms/second (single thread)
- **Batch creation** is faster than individual: `(Concept "a") (Concept "b") (Concept "c")`
- **Memory:** ~80–120 bytes per atom (C++ object + index entries)

## Queries

| Pattern | Performance | Notes |
|---|---|---|
| `(Get (Inheritance (Variable "$x") (Concept "c")))` | Fast | Indexed by type + name |
| `(Get (Inheritance (Variable "$x") (Variable "$y")))` | Slower | No type filter — scans more |
| `(Get (And ...))` | Moderate | Multiple sub-patterns joined |
| `(BindLink ...)` | Same as Get + rewrite | Rewrite adds overhead |

### Query Optimization Tips

1. **Use specific types** — `(cog-count-atoms 'ConceptNode)` filters by type
2. **Prefer named anchors** — querying against a specific `Concept "foo"` is faster than `Variable "$x"`
3. **Limit patterns** — each variable adds combinatorial cost to the matcher
4. **Avoid `(cog-atomspace)`** — dumps every atom; use targeted queries

## Memory

| Atom Count | Approx RAM |
|---|---|
| 1,000 | ~100 KB |
| 100,000 | ~10 MB |
| 1,000,000 | ~100 MB |
| 10,000,000 | ~1 GB (tested) |

- The atom table is a concurrent hash map — memory grows with atom count
- Each atom's incoming set is a linked list of pointers
- Values (FloatValue, StringValue, etc.) are allocated separately

## Concurrency

- **Reads:** Unlimited concurrent readers (read-write lock)
- **Writes:** Serialized — only one writer at a time
- **Thread pool:** CogServer handles each connection on its own thread

## Storage Backends

| Backend | Read | Write | Use Case |
|---|---|---|---|
| In-memory (default) | Fastest | Fastest | Development, ephemeral |
| RocksDB | Fast | Fast | Local persistence |
| PostgreSQL | Moderate | Moderate | Multi-client, remote |
| CogStorage | Network-bound | Network-bound | Distributed |

## Profiling

Use the REPL to measure:

```scheme
;; Time a query
(cog-evaluate! (Plus (Number 1) (Number 2)))

;; Count by type
(cog-count-atoms 'ConceptNode)

;; Atomspace size
(cog-count-atoms)
```
