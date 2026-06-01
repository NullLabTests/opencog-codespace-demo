;; ============================================================
;; OpenCog AtomSpace — Quick Demo
;; ============================================================
;; Creates atoms, builds relationships, runs queries,
;; and evaluates arithmetic.
;;
;; Usage:
;;   cat demo.scm | nc localhost 17001
;;   or paste into /websockets/demo.html
;; ============================================================

(use-modules (opencog))

(display "=== Creating Atoms ===\n")
(Concept "hello-world")
(Concept "opencog")
(Concept "AGI")

(display "\n=== Creating Relationships ===\n")
(Inheritance (Concept "cat") (Concept "animal"))
(Inheritance (Concept "dog") (Concept "animal"))
(Inheritance (Concept "animal") (Concept "living-thing"))

(display "\n=== Arithmetic Evaluation ===\n")
(cog-evaluate! (Plus (Number 1) (Number 2)))
(cog-evaluate! (Times (Number 6) (Number 7)))
(cog-evaluate! (GreaterThan (Number 10) (Number 5)))

(display "\n=== Pattern Matching ===\n")
(display "All children of 'animal':\n")
(cog-execute! (Get (Inheritance (Variable "$X") (Concept "animal"))))

(display "\n=== Atom Count ===\n")
(display (cog-count-atoms))

(display "\n\nDone! The AtomSpace is alive.\n")
