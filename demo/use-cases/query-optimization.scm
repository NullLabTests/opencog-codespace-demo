;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; ── Query Optimization Demo ──
;; Demonstrates efficient query patterns vs. slow ones
;; Usage: cat demo/use-cases/query-optimization.scm | nc localhost 17001

(use-modules (opencog))

(display "=== Building Knowledge Base ===\n")

;; Create a small taxonomy (50 concepts, 100 relationships)
(for-each (lambda (i)
    (let ((c (Concept (string-append "concept-" (number->string i)))))
        (when (> i 0)
            (Inheritance c
                (Concept (string-append "concept-"
                    (number->string (- i (min i 5)))))))))
    (iota 50))

(display "\n=== Query 1: Specific anchor (FAST) ===\n")
(time (cog-execute!
    (Get (Inheritance (Variable "$x") (Concept "concept-0")))))

(display "\n=== Query 2: Generic variable (SLOWER) ===\n")
(time (cog-execute!
    (Get (Inheritance (Variable "$x") (Variable "$y")))))

(display "\n=== Query 3: Filtered by type (EFFICIENT) ===\n")
(time (cog-execute!
    (Get (Inheritance (Variable "$x") (Concept "concept-5")))))

(display "\n=== Query 4: Count by type ===\n")
(display (string-append "Concept nodes: "
    (number->string (cog-count-atoms 'ConceptNode)) "\n"))
(display (string-append "Total atoms:   "
    (number->string (cog-count-atoms)) "\n"))

(display "\nDone.\n")
