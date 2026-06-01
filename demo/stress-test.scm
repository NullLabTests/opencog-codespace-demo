;; OpenCog AtomSpace — Stress Test
;; Bulk atom creation performance test
;;
;; Usage: cat demo/stress-test.scm | nc localhost 17001
;; WARNING: Creates 1000 atoms. Run only on a non-critical atomspace.

(display "=== Stress Test: Creating 1000 atoms ===\n")
(display "Start time: ")
(display (gettimeofday))
(newline)

(define count 1000)
(do ((i 0 (+ i 1)))
    ((= i count))
    (Concept (string-append "stress-atom-" (number->string i))))

(display "Created ")
(display count)
(display " atoms.\n")
(display "Total atoms now: ")
(display (cog-count-atoms))
(newline)
(display "End time: ")
(display (gettimeofday))
(newline)
(display "Stress test complete.\n")
