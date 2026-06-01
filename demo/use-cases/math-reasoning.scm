;; OpenCog AtomSpace — Math & Theorem Representation
;; Represent mathematical knowledge as atoms
;;
;; Usage: cat demo/use-cases/math-reasoning.scm | nc localhost 17001

;; ── Arithmetic truths ──
(Evaluation (Predicate "sum") (List (Number 2) (Number 3) (Number 5)))
(Evaluation (Predicate "sum") (List (Number 5) (Number 7) (Number 12)))
(Evaluation (Predicate "product") (List (Number 2) (Number 3) (Number 6)))
(Evaluation (Predicate "product") (List (Number 6) (Number 7) (Number 42)))

;; ── Algebraic properties ──
(Concept "commutative") (Concept "associative") (Concept "distributive")

(Evaluation (Predicate "property") (List (Predicate "sum")    (Concept "commutative")))
(Evaluation (Predicate "property") (List (Predicate "product")(Concept "commutative")))
(Evaluation (Predicate "property") (List (Predicate "sum")    (Concept "associative")))
(Evaluation (Predicate "property") (List (Predicate "product")(Concept "associative")))

;; ── Geometric shapes ──
(Concept "triangle") (Concept "square") (Concept "circle")
(Concept "polygon")  (Concept "shape")

(Inheritance (Concept "triangle") (Concept "polygon"))
(Inheritance (Concept "square")   (Concept "polygon"))
(Inheritance (Concept "polygon")  (Concept "shape"))
(Inheritance (Concept "circle")   (Concept "shape"))

(Evaluation (Predicate "sides") (List (Concept "triangle") (Number 3)))
(Evaluation (Predicate "sides") (List (Concept "square")   (Number 4)))
(Evaluation (Predicate "angles") (List (Concept "triangle") (Number 3)))
(Evaluation (Predicate "angles") (List (Concept "square")   (Number 4)))

;; ── Pythagorean theorem ──
(Concept "right-triangle")
(Concept "hypotenuse")
(Concept "leg")

(Evaluation (Predicate "has") (List (Concept "right-triangle") (Concept "hypotenuse")))
(Evaluation (Predicate "has") (List (Concept "right-triangle") (Concept "leg")))

;; ── Queries ──
(display "\n=== Shapes and their sides ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "sides") (List (Variable "$s") (Variable "$n")))))

(display "\n=== Polygons ===\n")
(cog-execute! (Get (Inheritance (Variable "$x") (Concept "polygon"))))

(display "\n=== Commutative operations ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "property") (List (Variable "$op") (Concept "commutative")))))
