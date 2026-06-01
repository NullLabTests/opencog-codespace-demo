# Glossary of OpenCog Terminology

**Atom** — The fundamental unit of knowledge in the AtomSpace. Each atom has a type, a name (optional), an outgoing set (the atoms it links to), an incoming set (atoms linking to it), and optionally values and truth values.

**AtomSpace** — The in-memory hypergraph database that stores all atoms. Provides query, indexing, and manipulation operations.

**Atomese** — The native language of the AtomSpace. It is embedded in GNU Guile Scheme, so every Scheme expression is valid Atomese, and every atom is a first-class Scheme value.

**BindLink** — A link type that pairs a pattern (what to match) with a rewrite (what to create). The AtomSpace pattern matcher finds all matches of the pattern and instantiates the rewrite for each one.

**CogServer** — The network server that wraps the AtomSpace and provides REPL (telnet), WebSocket, HTTP, and MCP access.

**cogutil** — The shared C++ utility library used by all OpenCog components. Provides threading, logging, serialization, and atomics.

**EvaluationLink** — A link type representing a predicate applied to arguments. Example: `(Evaluation (Predicate "color") (List (Concept "sky") (Concept "blue")))`.

**GetLink** — A link type used for querying the atomspace. It wraps a pattern and returns all matching subgraphs.

**GroundedSchemaNode** — A node that references external code (Python, C++, etc.) that can be executed by the AtomSpace. Used for connecting to external systems.

**Guile** — GNU Guile is the Scheme language interpreter that the AtomSpace REPL is embedded in. Version 3.0.

**Hypergraph** — A graph where edges can connect any number of nodes (not just two). The AtomSpace is a hypergraph database.

**Hyperon** — The next-generation OpenCog architecture, under development at TrueAGI. Uses the MeTTa language.

**InheritanceLink** — A link type representing an IS-A relationship. Example: `(Inheritance (Concept "cat") (Concept "animal"))`.

**Link** — An atom that connects other atoms via its outgoing set. Links are the edges of the knowledge graph.

**MemberLink** — A link type representing set membership. Example: `(Member (Concept "alice") (Concept "programmers"))`.

**Metagraph** — A graph where nodes and edges are the same kind of object (atoms). In the AtomSpace, every atom can be both a node (target of links) and a link (connecting other atoms).

**MeTTa** — The programming language of OpenCog Hyperon. Combines logic, functional, and probabilistic programming.

**MOSES** — Meta-Optimizing Semantic Evolutionary Search. An OpenCog component for program evolution and optimization.

**Node** — An atom with a name but no outgoing set. Leaf atoms in the graph.

**Pattern Matcher** — The AtomSpace's subgraph isomorphism engine. Finds all subgraphs matching a given pattern with variables.

**PLN** — Probabilistic Logic Networks. An OpenCog component for term-level probabilistic reasoning with truth value propagation.

**PredicateNode** — A node type used to name a predicate or relation.

**RocksDBStorageNode** — A storage backend that persists the atomspace to local disk via RocksDB.

**Scheme** — A dialect of Lisp. The primary scripting language for OpenCog Classic.

**SimpleTruthValue** — A truth value with two components: strength (0.0–1.0, degree of belief) and confidence (0.0–1.0, certainty of that belief).

**Type** — Every atom has a type that determines its role. There are 60+ built-in types in a single-inheritance hierarchy.

**Value** — Key-value data that can be attached to any atom. Types include FloatValue, StringValue, LinkValue, and others.

**VariableNode** — A node type used as a placeholder in patterns and queries. Conventionally named with a `$` prefix.
