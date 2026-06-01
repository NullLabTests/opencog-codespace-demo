;; OpenCog AtomSpace — Multi-Generational Family Tree
;; Demonstrates complex inheritance, queries, and property inference
;;
;; Usage: cat demo/use-cases/family-tree.scm | nc localhost 17001

;; ── People ──
(Concept "alice") (Concept "bob") (Concept "charlie")
(Concept "diana") (Concept "eve") (Concept "frank")
(Concept "grace") (Concept "henry")

;; ── Generations ──
(Inheritance (Concept "alice") (Concept "generation-1"))
(Inheritance (Concept "bob")   (Concept "generation-1"))
(Inheritance (Concept "charlie") (Concept "generation-2"))
(Inheritance (Concept "diana") (Concept "generation-2"))
(Inheritance (Concept "eve")   (Concept "generation-3"))
(Inheritance (Concept "frank") (Concept "generation-3"))
(Inheritance (Concept "grace") (Concept "generation-4"))
(Inheritance (Concept "henry") (Concept "generation-4"))

;; ── Parent-Child ──
(Inheritance (Concept "alice") (Predicate "parent-of") (Concept "charlie"))
(Inheritance (Concept "bob")   (Predicate "parent-of") (Concept "charlie"))
(Inheritance (Concept "charlie") (Predicate "parent-of") (Concept "eve"))
(Inheritance (Concept "diana") (Predicate "parent-of") (Concept "eve"))
(Inheritance (Concept "eve")   (Predicate "parent-of") (Concept "grace"))
(Inheritance (Concept "frank") (Predicate "parent-of") (Concept "grace"))

;; ── Properties ──
(Evaluation (Predicate "occupation") (List (Concept "alice")   (Concept "engineer")))
(Evaluation (Predicate "occupation") (List (Concept "bob")     (Concept "teacher")))
(Evaluation (Predicate "occupation") (List (Concept "charlie") (Concept "doctor")))
(Evaluation (Predicate "occupation") (List (Concept "eve")     (Concept "artist")))
(Evaluation (Predicate "occupation") (List (Concept "grace")   (Concept "student")))

;; ── Queries ──
(display "\n=== Generation 2 members ===\n")
(cog-execute! (Get (Inheritance (Variable "$p") (Concept "generation-2"))))

(display "\n=== Children of generation-1 ===\n")
(cog-execute! (Get
    (And (Inheritance (Concept "alice") (Predicate "parent-of") (Variable "$c"))
         (Inheritance (Concept "bob")   (Predicate "parent-of") (Variable "$c")))))

(display "\n=== All occupations ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "occupation") (List (Variable "$p") (Variable "$o")))))
