;; OpenCog AtomSpace — Taxonomy Demo
;; Build and query a biological classification hierarchy
;;
;; Usage: cat demo/use-cases/taxonomy.scm | nc localhost 17001

(Concept "animal")
(Concept "chordate")
(Concept "mammal")
(Concept "carnivore")
(Concept "felidae")
(Concept "felis")
(Concept "domestic-cat")

(Inheritance (Concept "domestic-cat") (Concept "felis"))
(Inheritance (Concept "felis")        (Concept "felidae"))
(Inheritance (Concept "felidae")      (Concept "carnivore"))
(Inheritance (Concept "carnivore")    (Concept "mammal"))
(Inheritance (Concept "mammal")       (Concept "chordate"))
(Inheritance (Concept "chordate")     (Concept "animal"))

(display "\n=== Ancestors of domestic-cat ===\n")
(cog-execute! (Get (Inheritance (Concept "domestic-cat") (Variable "$x"))))
