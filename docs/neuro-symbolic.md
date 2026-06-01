# Neuro-Symbolic AI with AtomSpace + LLMs

The AtomSpace is a natural fit for **neuro-symbolic AI** — combining
neural network representations (embeddings, LLMs) with symbolic reasoning
(knowledge graphs, logic, inference).

## Pattern: LLM → AtomSpace

An LLM extracts structured facts from text, stored as atoms:

```python
import openai, json, websockets, asyncio

# 1. LLM extracts facts from text
text = "The Eiffel Tower is in Paris. It was built in 1889."
response = openai.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user",
               "content": f"Extract facts as triples (subject, predicate, object): {text}"}]
)

# 2. Store facts in AtomSpace
async def store_fact(s, p, o):
    expr = f'(Evaluation (Predicate "{p}") (List (Concept "{s}") (Concept "{o}")))'
    async with websockets.connect("ws://localhost:18080/json") as ws:
        await ws.send(json.dumps({"command": "scheme", "body": expr}))
        return await ws.recv()

facts = [("EiffelTower", "located-in", "Paris"),
         ("EiffelTower", "built-year", "1889")]
for s, p, o in facts:
    asyncio.run(store_fact(s, p, o))
```

## Pattern: AtomSpace → LLM

Query the AtomSpace and feed results into an LLM prompt:

```python
async def query_atomspace(pattern):
    expr = f'(cog-execute! (Get {pattern}))'
    async with websockets.connect("ws://localhost:18080/json") as ws:
        await ws.send(json.dumps({"command": "scheme", "body": expr}))
        return json.loads(await ws.recv())["result"]

# Get all facts about EiffelTower
facts = asyncio.run(query_atomspace(
    '(Evaluation (Variable "$p") (List (Concept "EiffelTower") (Variable "$v")))'
))

# Feed into LLM
prompt = f"Based on this knowledge: {facts}\nAnswer: What year was the Eiffel Tower built?"
```

## Pattern: Symbolic Reasoning over LLM Output

LLM outputs can be refined through symbolic rules:

```scheme
;; Rule: if X is in Y and Y is in Z, then X is in Z
(Implication
    (And (Evaluation (Predicate "located-in") (List (Variable "$x") (Variable "$y")))
         (Evaluation (Predicate "located-in") (List (Variable "$y") (Variable "$z"))))
    (Evaluation (Predicate "located-in") (List (Variable "$x") (Variable "$z"))))
```

## Pattern: Embeddings as Atom Values

Store LLM embeddings directly on atoms:

```scheme
;; Attach embedding vector to a concept
(cog-set-value! (Concept "transformer")
    (Predicate "embedding")
    (FloatValue 0.12 -0.45 0.78 0.33 -0.91 ...))
```

## Why This Matters

| Approach | Strength | Weakness |
|---|---|---|
| LLM alone | Fluency, breadth | Hallucination, no guarantees |
| AtomSpace alone | Precision, inference | No natural language |
| **Together** | Both strengths | Integration complexity |

The AtomSpace provides the **guarantees** (facts are explicit, inference is
sound) while the LLM provides the **interface** (natural language, world
knowledge).
