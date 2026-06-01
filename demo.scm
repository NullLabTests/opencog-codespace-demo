;;;
;;; OpenCog AtomSpace Demo Script
;;; Run with: cat demo.scm | nc localhost 17001
;;; Or paste into the WebSocket Shell at /websockets/demo.html
;;;

(use-modules (opencog))

; --- 1. Basic Atoms ---
(display "=== Creating Atoms ===\n")

(ConceptNode "hello-world")
(ConceptNode "opencog")
(ConceptNode "AGI")

; --- 2. Relationships ---
(display "=== Creating Relationships ===\n")

(InheritanceLink (ConceptNode "cat") (ConceptNode "animal"))
(InheritanceLink (ConceptNode "dog") (ConceptNode "animal"))
(InheritanceLink (ConceptNode "animal") (ConceptNode "living-thing"))

; --- 3. Arithmetic ---
(display "=== Arithmetic ===\n")
(cog-evaluate! (Plus (Number 1) (Number 2)))
(cog-evaluate! (Times (Number 6) (Number 7)))

; --- 4. Evaluation ---
(display "=== Evaluation ===\n")
(cog-evaluate! (GreaterThan (Number 10) (Number 5)))

; --- 5. Query ---
(display "=== Pattern Matching ===\n")
(cog-execute! (Get (InheritanceLink (VariableNode "$X") (ConceptNode "animal"))))

; --- 6. Count ---
(display "=== Atom Count ===\n")
(cog-count-atoms 'ConceptNode)

(display "\nDone! The AtomSpace is alive.\n")
