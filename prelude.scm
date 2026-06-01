;; ── REPL Prelude — Common Utilities ──
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog
;;
;; Load with: cat prelude.scm | nc localhost 17001
;; Or add to CogServer init script.

(use-modules (opencog))
(use-modules (opencog query))
(use-modules (opencog exec))

;; ── Display helpers ──

(define (show-atom a)
    "Pretty-print an atom with its type and name."
    (display (cog-type a))
    (display " \"")
    (display (cog-name a))
    (display "\"\n"))

(define (show-all)
    "Display every atom in the atomspace."
    (map show-atom (cog-atomspace)))

(define (count-by-type)
    "Count atoms grouped by type."
    (map (lambda (t)
        (display t) (display ": ")
        (display (cog-count-atoms t)) (newline))
        (cog-get-types)))

;; ── Query helpers ──

(define (find-children concept)
    "Find all direct children of a concept."
    (cog-execute! (Get (Inheritance (Variable "$x") concept))))

(define (find-parents concept)
    "Find all direct parents of a concept."
    (cog-execute! (Get (Inheritance concept (Variable "$y")))))

(define (find-all-relations concept)
    "Find all atoms related to a concept via any link."
    (cog-incoming-set concept))

;; ── Utility ──

(define (clear-all)
    "Delete all atoms from the atomspace."
    (map cog-delete-recursive (cog-atomspace)))
