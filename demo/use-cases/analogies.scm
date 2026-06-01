;; OpenCog AtomSpace — Analogical Reasoning
;; Represent analogies between domains
;;
;; Usage: cat demo/use-cases/analogies.scm | nc localhost 17001

;; ── Solar System Domain ──
(Concept "sun")     (Concept "planet")  (Concept "moon")
(Concept "earth")   (Concept "solar-system")

(Evaluation (Predicate "orbits") (List (Concept "earth") (Concept "sun")))
(Evaluation (Predicate "orbits") (List (Concept "moon")  (Concept "earth")))
(Member (Concept "earth") (Concept "planet"))
(Member (Concept "sun")   (Concept "star"))

;; ── Atom Domain ──
(Concept "nucleus") (Concept "electron") (Concept "atom")
(Evaluation (Predicate "orbits") (List (Concept "electron") (Concept "nucleus")))

;; ── Analogy: atom is like solar-system ──
(Similarity (Concept "atom") (Concept "solar-system"))

;; Structural mapping via SimilarityLink
(Similarity (Concept "nucleus")  (Concept "sun"))
(Similarity (Concept "electron") (Concept "planet"))

;; ── Analogical Inference ──
;; If nucleus:electron :: sun:planet, and sun has property X,
;; then nucleus may also have property X.

(display "\n=== Orbital relationships ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "orbits") (List (Variable "$satellite") (Variable "$center")))))

(display "\n=== Analogy mappings ===\n")
(cog-execute! (Get
    (Similarity (Variable "$a") (Variable "$b"))))
