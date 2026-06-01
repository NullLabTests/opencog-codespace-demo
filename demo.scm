;; ============================================================
;; OpenCog AtomSpace — Quick Demo
;; ============================================================
;; This script creates atoms, builds relationships, runs queries,
;; and evaluates arithmetic — everything you need to verify that
;; the AtomSpace is alive and working.
;;
;; Usage:
;;   cat demo.scm | nc localhost 17001
;;   or paste into /websockets/demo.html
;; ============================================================

(use-modules (opencog))

(display "=== Creating Atoms ===\n")
(ConceptNode "hello-world")
(ConceptNode "opencog")
(ConceptNode "AGI")

(display "\n=== Creating Relationships ===\n")
(InheritanceLink (ConceptNode "cat") (ConceptNode "animal"))
(InheritanceLink (ConceptNode "dog") (ConceptNode "animal"))
(InheritanceLink (ConceptNode "animal") (ConceptNode "living-thing"))

(display "\n=== Arithmetic Evaluation ===\n")
(cog-evaluate! (Plus (Number 1) (Number 2)))
(cog-evaluate! (Times (Number 6) (Number 7)))
(cog-evaluate! (GreaterThan (Number 10) (Number 5)))

(display "\n=== Pattern Matching ===\n")
(display "All children of 'animal':\n")
(cog-execute! (Get (InheritanceLink (VariableNode "$X") (ConceptNode "animal"))))

(display "\n=== Atom Count ===\n")
(display (cog-count-atoms))

(display "\n\nDone! The AtomSpace is alive.\n")
