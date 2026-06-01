;; OpenCog AtomSpace — Commonsense Reasoning
;; Everyday knowledge and simple inference rules
;;
;; Usage: cat demo/use-cases/commonsense.scm | nc localhost 17001

;; ── Objects ──
(Concept "sky")     (Concept "grass")   (Concept "snow")
(Concept "sun")     (Concept "rain")    (Concept "cloud")
(Concept "bird")    (Concept "fish")    (Concept "tree")

;; ── Properties ──
(Evaluation (Predicate "color") (List (Concept "sky")   (Concept "blue")))
(Evaluation (Predicate "color") (List (Concept "grass") (Concept "green")))
(Evaluation (Predicate "color") (List (Concept "snow")  (Concept "white")))
(Evaluation (Predicate "color") (List (Concept "sun")   (Concept "yellow")))

;; ── Locations ──
(Evaluation (Predicate "lives-in") (List (Concept "bird") (Concept "sky")))
(Evaluation (Predicate "lives-in") (List (Concept "fish") (Concept "water")))
(Evaluation (Predicate "lives-in") (List (Concept "bird") (Concept "tree")))

;; ── Causes ──
(Implication (Concept "rain") (Concept "wet-ground"))
(Implication (Concept "sun")  (Concept "warm"))
(Implication (Concept "cloud") (Concept "rain"))

;; ── Classification ──
(Inheritance (Concept "bird") (Concept "animal"))
(Inheritance (Concept "fish") (Concept "animal"))
(Inheritance (Concept "tree") (Concept "plant"))
(Inheritance (Concept "grass") (Concept "plant"))

;; ── Queries ──
(display "\n=== Things that are blue ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "color") (List (Variable "$x") (Concept "blue")))))

(display "\n=== Animals ===\n")
(cog-execute! (Get (Inheritance (Variable "$x") (Concept "animal"))))

(display "\n=== Implication chain: cloud causes? ===\n")
(cog-execute! (Get
    (Implication (Concept "cloud") (Variable "$effect"))))
