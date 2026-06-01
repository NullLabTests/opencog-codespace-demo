;; ============================================================
;; OpenCog AtomSpace — Comprehensive Demo Script
;; ============================================================
;; Pipe this file into the CogServer REPL:
;;   cat demo/comprehensive-demo.scm | nc localhost 17001
;;
;; Or paste sections interactively via telnet localhost 17001
;; ============================================================

(display "╔══════════════════════════════════════════════╗\n")
(display "║  OpenCog AtomSpace Comprehensive Demo        ║\n")
(display "╚══════════════════════════════════════════════╝\n")
(newline)

;; ─── Part 1: Basic Atoms ──────────────────────────────────
(display "─── Part 1: Creating Atoms ───\n")

(Concept "hello-world")
(Concept "opencog")
(Concept "AGI")
(Concept "artificial-intelligence")
(Concept "machine-learning")
(Concept "deep-learning")
(Concept "neural-network")
(Concept "symbolic-ai")
(Concept "knowledge-graph")
(Concept "nlp")
(Concept "computer-vision")
(Concept "robotics")

(display "Created 11 Concept nodes.\n")
(newline)

(display "Atom count: ")
(display (cog-count-atoms))
(newline)
(newline)

;; ─── Part 2: Inheritance Hierarchy ────────────────────────
(display "─── Part 2: Building a Knowledge Taxonomy ───\n")

;; animals
(Concept "animal")
(Concept "mammal")
(Concept "reptile")
(Concept "bird")
(Concept "fish")
(Concept "cat")
(Concept "dog")
(Concept "eagle")
(Concept "salmon")
(Concept "snake")
(Concept "horse")
(Concept "dolphin")

(Inheritance (Concept "cat")     (Concept "mammal"))
(Inheritance (Concept "dog")     (Concept "mammal"))
(Inheritance (Concept "horse")   (Concept "mammal"))
(Inheritance (Concept "dolphin") (Concept "mammal"))
(Inheritance (Concept "eagle")   (Concept "bird"))
(Inheritance (Concept "snake")   (Concept "reptile"))
(Inheritance (Concept "salmon")  (Concept "fish"))
(Inheritance (Concept "mammal")  (Concept "animal"))
(Inheritance (Concept "reptile") (Concept "animal"))
(Inheritance (Concept "bird")    (Concept "animal"))
(Inheritance (Concept "fish")    (Concept "animal"))
(Inheritance (Concept "animal")  (Concept "living-thing"))

(display "Built a taxonomy with 23 InheritanceLinks.\n")
(newline)

;; ─── Part 3: Properties with EvaluationLink ───────────────
(display "─── Part 3: Properties & Attributes ───\n")

;; Predicates
(Predicate "has-color")
(Predicate "has-size")
(Predicate "has-diet")
(Predicate "has-habitat")
(Predicate "has-lifespan")
(Predicate "can-fly")
(Predicate "can-swim")

;; Color
(Evaluation (Predicate "has-color")
    (List (Concept "sky")      (Concept "blue")))
(Evaluation (Predicate "has-color")
    (List (Concept "grass")    (Concept "green")))
(Evaluation (Predicate "has-color")
    (List (Concept "snow")     (Concept "white")))

;; Diet
(Evaluation (Predicate "has-diet")
    (List (Concept "cat")      (Concept "carnivore")))
(Evaluation (Predicate "has-diet")
    (List (Concept "dog")      (Concept "omnivore")))
(Evaluation (Predicate "has-diet")
    (List (Concept "horse")    (Concept "herbivore")))

;; Flight
(Evaluation (Predicate "can-fly")
    (List (Concept "eagle")    (Concept "true")))
(Evaluation (Predicate "can-fly")
    (List (Concept "cat")      (Concept "false")))

;; Swimming
(Evaluation (Predicate "can-swim")
    (List (Concept "dolphin")  (Concept "true")))
(Evaluation (Predicate "can-swim")
    (List (Concept "cat")      (Concept "false")))
(Evaluation (Predicate "can-swim")
    (List (Concept "salmon")   (Concept "true")))

(display "Added 10 property evaluations.\n")
(newline)

;; ─── Part 4: Membership & Part-Whole ──────────────────────
(display "─── Part 4: Set Membership & Mereology ───\n")

(Concept "my-pets")

(Member (Concept "cat") (Concept "my-pets"))
(Member (Concept "dog") (Concept "my-pets"))

(Concept "common-pets")
(Member (Concept "cat") (Concept "common-pets"))
(Member (Concept "dog") (Concept "common-pets"))
(Member (Concept "horse") (Concept "common-pets"))

(Concept "animal-body")
(Concept "head")
(Concept "legs")
(Concept "tail")

(PartOf (Concept "head")  (Concept "animal-body"))
(PartOf (Concept "legs")  (Concept "animal-body"))
(PartOf (Concept "tail")  (Concept "animal-body"))

(display "Added membership and part-whole relationships.\n")
(newline)

;; ─── Part 5: Similarity & Association ─────────────────────
(display "─── Part 5: Similarity & Associations ───\n")

;; Dogs are similar to wolves
(Similarity (Concept "dog") (Concept "wolf"))

;; Dolphins and fish both swim
(Similarity (Concept "dolphin") (Concept "fish"))

;; Knowledge domain associations
(Associative (Concept "machine-learning")   (Concept "deep-learning"))
(Associative (Concept "machine-learning")   (Concept "neural-network"))
(Associative (Concept "symbolic-ai")        (Concept "knowledge-graph"))
(Associative (Concept "machine-learning")   (Concept "symbolic-ai"))

(display "Added similarity and associative links.\n")
(newline)

;; ─── Part 6: Querying ─────────────────────────────────────
(display "─── Part 6: Querying the AtomSpace ───\n")

(display "All atoms count: ")
(display (cog-count-atoms))
(newline)

(display "Node count: ")
(display (cog-count-nodes))
(newline)

(display "Link count: ")
(display (cog-count-links))
(newline)
(newline)

(display "Finding all mammals:\n")
(cog-execute! (Get
    (Inheritance (Variable "$x") (Concept "mammal"))))
(newline)

(display "Finding everything that inherits from something:\n")
(cog-execute! (Get
    (Inheritance (Variable "$child") (Variable "$parent"))))
(newline)

(display "Finding all carnivores:\n")
(cog-execute! (Get
    (Evaluation (Predicate "has-diet")
        (List (Variable "$x") (Concept "carnivore")))))
(newline)

(display "Finding everything that can fly:\n")
(cog-execute! (Get
    (Evaluation (Predicate "can-fly")
        (List (Variable "$x") (Concept "true")))))
(newline)

;; ─── Part 7: Graph Rewriting ──────────────────────────────
(display "─── Part 7: Graph Rewriting ───\n")

;; Automatically classify all animals as "living-thing"
(cog-execute! (Bind
    (Inheritance (Variable "$X") (Concept "animal"))
    (Inheritance (Variable "$X") (Concept "living-thing"))))

;; Verify
(display "All things that inherit from living-thing:\n")
(cog-execute! (Get
    (Inheritance (Variable "$x") (Concept "living-thing"))))
(newline)

;; ─── Part 8: Truth Values ─────────────────────────────────
(display "─── Part 8: Working with Truth Values ───\n")

;; Create an atom with explicit truth value
(cog-new-link 'InheritanceLink
    (Concept "cat")
    (Concept "mammal")
    (cog-new-stv 1.0 0.95))

(display "Truth value of cat→mammal: ")
(display (cog-tv (Inheritance (Concept "cat") (Concept "mammal"))))
(newline)

;; ─── Part 9: Arithmetic ───────────────────────────────────
(display "─── Part 9: Arithmetic Evaluation ───\n")

(cog-evaluate! (Plus (Number 1) (Number 2)))
(cog-evaluate! (Times (Number 6) (Number 7)))
(cog-evaluate! (GreaterThan (Number 100) (Number 42)))
(cog-evaluate! (Equal (Number 42) (Number 42)))

(display "Arithmetic evaluation complete.\n")
(newline)

;; ─── Part 10: AtomSpace Statistics ────────────────────────
(display "─── Part 10: Summary ───\n")
(newline)
(display "Final AtomSpace state:\n")
(display "======================\n")
(cog-prt-atomspace)
(newline)
(display "Demo complete. Open the visualizer or WebSocket shell to explore.\n")
