;; ── Comparison Benchmark: Classic vs Hyperon style ──
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog
;;
;; Measures atom creation and query throughput in OpenCog Classic.
;; For a comparison with Hyperon/MeTTa, see docs/migration-guide.md.

(use-modules (opencog))

(display "=== Comparison Benchmark: Classic AtomSpace ===\n")

;; ── Benchmark 1: Atom Creation (Classic) ──
(display "\n--- Benchmark 1: Atom Creation ---\n")
(let* ((start (gettimeofday))
       (count 5000))
    (do ((i 0 (+ i 1)))
        ((>= i count))
        (Inheritance
            (Concept (string-append "bench-x-" (number->string i)))
            (Concept "bench-root")))
    (let* ((end (gettimeofday))
           (elapsed (- (car end) (car start))))
        (display (string-append "Created " (number->string count)
            " links in " (number->string elapsed) "s\n"))
        (display (string-append "Throughput: "
            (number->string (inexact->exact (round (/ count elapsed))))
            " links/s\n"))))

;; ── Benchmark 2: Pattern Query (Classic) ──
(display "\n--- Benchmark 2: Pattern Query ---\n")
(let* ((start (gettimeofday))
       (iterations 50))
    (do ((i 0 (+ i 1)))
        ((>= i iterations))
        (cog-execute! (Get
            (Inheritance (Variable "$x") (Concept "bench-root")))))
    (let* ((end (gettimeofday))
           (elapsed (- (car end) (car start))))
        (display (string-append "Ran " (number->string iterations)
            " queries in " (number->string elapsed) "s\n"))
        (display (string-append "Query rate: "
            (number->string (inexact->exact (round (/ iterations elapsed))))
            " q/s\n"))))

;; ── Benchmark 3: Graph Rewrite (Classic) ──
(display "\n--- Benchmark 3: Graph Rewrite ---\n")
(let* ((start (gettimeofday))
       (iterations 10))
    (do ((i 0 (+ i 1)))
        ((>= i iterations))
        (cog-execute! (Bind
            (Inheritance (Variable "$x") (Concept "bench-root"))
            (Inheritance (Variable "$x") (Variable "$y")))))
    (let* ((end (gettimeofday))
           (elapsed (- (car end) (car start))))
        (display (string-append "Ran " (number->string iterations)
            " rewrites in " (number->string elapsed) "s\n"))))

(display "\n=== Benchmark Complete ===\n")
(display (string-append "Total atoms: " (number->string (cog-count-atoms)) "\n"))
