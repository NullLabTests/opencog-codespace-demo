# Use-Case Demo Scripts

These scripts demonstrate specific knowledge representation patterns
using the OpenCog AtomSpace. Each is a standalone `.scm` file that
can be piped directly into the CogServer REPL.

## How to Run

```bash
cat demo/use-cases/<script>.scm | nc localhost 17001
```

Or open the WebSocket Shell (`http://localhost:18080/websockets/demo.html`)
and paste the contents.

## Scripts

| Script | Domain | Concepts |
|---|---|---|
| [taxonomy.scm](taxonomy.scm) | Biology | Inheritance hierarchy, classification queries |
| [family-tree.scm](family-tree.scm) | Genealogy | Multi-generational relations, property queries |
| [expert-system.scm](expert-system.scm) | Medicine | Rule-based diagnosis with implication links |
| [commonsense.scm](commonsense.scm) | Everyday knowledge | Object properties, locations, causal chains |
| [planning.scm](planning.scm) | Robotics | State representation, action preconditions |
| [temporal.scm](temporal.scm) | Scheduling | Events, time points, ordering (Before/AtTime) |
| [semantic-net.scm](semantic-net.scm) | Philosophy | Classic Socrates syllogism, network queries |
| [analogies.scm](analogies.scm) | Cognition | Cross-domain analogy via SimilarityLink |
| [math-reasoning.scm](math-reasoning.scm) | Mathematics | Arithmetic truths, geometric properties |
| [reasoning-pipeline.scm](reasoning-pipeline.scm) | Multi-domain | Chain: taxonomy → properties → rewrite → cross-query |
| [rewriting.scm](rewriting.scm) | Inference | BindLink-based automatic knowledge inference |

## Suggested Order

For newcomers, run in this order:

1. `taxonomy.scm` — simplest pattern
2. `commonsense.scm` — familiar concepts
3. `family-tree.scm` — multiple relation types
4. `expert-system.scm` — rule-based reasoning
5. `reasoning-pipeline.scm` — everything combined

## Creating New Scripts

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines. Each new
script should add a genuinely new knowledge pattern not already covered.
