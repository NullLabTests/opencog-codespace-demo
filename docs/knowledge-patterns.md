# Knowledge Representation Patterns

A collection of common knowledge representation patterns in Atomese,
from simple to advanced.

## 1. Classification (IS-A)

The simplest and most common pattern: X is a type of Y.

```scheme
(Inheritance (Concept "poodle") (Concept "dog"))
(Inheritance (Concept "dog")    (Concept "mammal"))
(Inheritance (Concept "mammal") (Concept "animal"))
```

**Use case:** Taxonomies, ontologies, class hierarchies.

## 2. Attribute / Property

An entity has some attribute or property.

```scheme
(Evaluation
    (Predicate "has-color")
    (List (Concept "sky") (Concept "blue")))
```

**Use case:** Describing properties of objects (color, size, weight, etc.).

## 3. Frame / Slot

A structured frame with multiple slots:

```scheme
(Evaluation
    (Predicate "person")
    (List
        (Concept "alice")
        (Concept "age"      (NumberNode 30))
        (Concept "occupation" (Concept "engineer"))
        (Concept "location"   (Concept "new-york"))))
```

**Use case:** Complex entity descriptions with multiple attributes.

## 4. Relations (N-ary)

A relation between two or more entities:

```scheme
(Evaluation
    (Predicate "between")
    (List
        (Concept "san-francisco")
        (Concept "los-angeles")
        (Concept "san-diego")))
```

**Use case:** Spatial, temporal, and other multi-argument relations.

## 5. Set Membership

An entity belongs to a set or category:

```scheme
(Member
    (Concept "alice")
    (Concept "programmers"))
```

**Use case:** Categories that aren't inheritance-based; grouping.

## 6. Part-Whole (Mereology)

One entity is part of another:

```scheme
(PartOf
    (Concept "wheel")
    (Concept "car"))
```

**Use case:** Compositional hierarchies, physical parts.

## 7. Similarity

Two entities are similar in some respect:

```scheme
(Similarity
    (Concept "car")
    (Concept "truck"))
```

**Use case:** Analogies, similarity-based reasoning.

## 8. Associative / Co-occurrence

Two entities are associated (non-hierarchical connection):

```scheme
(Associative
    (Concept "rain")
    (Concept "umbrella"))
```

**Use case:** Weak associations, common sense, co-occurrence data.

## 9. Time / Temporal

An event at a specific time:

```scheme
(AtTime
    (Concept "meeting")
    (Time "2026-06-01 17:00:00"))
```

**Use case:** Scheduling, event sequences, temporal reasoning.

## 10. Conditional / Implication

If X holds, then Y holds:

```scheme
(Implication
    (Evaluation
        (Predicate "is-raining")
        (List (Concept "outside")))
    (Evaluation
        (Predicate "is-wet")
        (List (Concept "ground"))))
```

**Use case:** Rules, cause-effect, logical implications.

## 11. Quantified Statements

For all X with property P, statement Q holds:

```scheme
(ForAll
    (List (Variable "$X"))
    (Implication
        (Inheritance
            (Variable "$X")
            (Concept "bird"))
        (Evaluation
            (Predicate "has-feathers")
            (List (Variable "$X")))))
```

**Use case:** General knowledge, rules with universal quantification.

## 12. Execution / Grounded Atoms

Call into external code:

```scheme
;; GroundedSchemaNode calls a Python or C++ function
(Execution
    (GroundedSchema "py: my_module.my_function")
    (List (Concept "input"))
    (Concept "output"))
```

**Use case:** Connecting the AtomSpace to external systems, APIs, sensors.

## Pattern Reference Card

```
                     Pattern                     │   Link Type
─────────────────────────────────────────────────┼───────────────────
X IS-A Y                                        │ InheritanceLink
X HAS property P with value V                   │ EvaluationLink
X IS-MEMBER-OF set S                            │ MemberLink
X IS-PART-OF Y                                  │ PartOfLink
X IS-SIMILAR-TO Y                               │ SimilarityLink
X IS-ASSOCIATED-WITH Y                          │ AssociativeLink
X at time T                                     │ AtTimeLink
IF X THEN Y                                     │ ImplicationLink
ALL X have property P                           │ ForAllLink
SOME X have property P                          │ ThereExistsLink
Execute function F with input I, output O       │ ExecutionLink
```
