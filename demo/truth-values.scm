;; OpenCog AtomSpace — Truth Value Exploration
;; Demonstrates different truth value types and operations
;;
;; Usage: cat demo/truth-values.scm | nc localhost 17001

(display "=== Truth Value Exploration ===\n\n")

;; SimpleTruthValue: strength (0-1) + confidence (0-1)
(display "--- SimpleTruthValue ---\n")
(define tv (cog-new-stv 0.95 0.8))
(display "Created STV with strength=0.95, confidence=0.8\n")

;; Attach to atoms
(define cat (Concept "cat"))
(define animal (Concept "animal"))
(define link (Inheritance cat animal))

(cog-set-tv! cat tv)
(cog-set-tv! link tv)

(display "cat TV: ")
(display (cog-tv cat))
(newline)
(display "link TV: ")
(display (cog-tv link))
(newline)

;; Default truth value
(display "\n--- Default TV ---\n")
(define bird (Concept "bird"))
(display "bird (no TV set): ")
(display (cog-tv bird))
(newline)

;; Truth value components
(display "\n--- TV Components ---\n")
(display "strength: ")
(display (tv-mean (cog-tv cat)))
(newline)
(display "confidence: ")
(display (tv-confidence (cog-tv cat)))
(newline)
(display "count: ")
(display (tv-count (cog-tv cat)))
(newline)

;; Merge truth values
(display "\n--- TV Merge ---\n")
(define tv2 (cog-new-stv 0.7 0.6))
(cog-set-tv! cat tv2)
(display "cat TV after update: ")
(display (cog-tv cat))
(newline)
