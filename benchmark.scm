;; ── AtomSpace Benchmark Suite ──
;; Measures creation throughput and query performance
;; Usage: cat benchmark.scm | nc localhost 17001

(use-modules (opencog))

(display "=== AtomSpace Benchmark Suite ===\n")

;; ── Benchmark 1: Sequential atom creation ──
(display "\n--- Benchmark 1: Sequential Creation ---\n")
(let* ((start (gettimeofday))
       (count 10000))
    (do ((i 0 (+ i 1)))
        ((>= i count))
        (Concept (string-append "bench-" (number->string i))))
    (let* ((end (gettimeofday))
           (elapsed (- (car end) (car start))))
        (display (string-append "Created " (number->string count)
            " atoms in " (number->string elapsed) "s\n"))
        (display (string-append "Throughput: "
            (number->string (inexact->exact (round (/ count elapsed))))
            " atoms/s\n"))))

;; ── Benchmark 2: Batch creation ──
(display "\n--- Benchmark 2: Batch Creation ---\n")
(let* ((start (gettimeofday))
       (count 5000))
    (apply begin
        (map (lambda (i)
            (Inheritance
                (Concept (string-append "bench-b-" (number->string i)))
                (Concept (string-append "bench-b-" (number->string (modulo i 100))))))
            (iota count)))
    (let* ((end (gettimeofday))
           (elapsed (- (car end) (car start))))
        (display (string-append "Created " (number->string count)
            " links in " (number->string elapsed) "s\n"))
        (display (string-append "Throughput: "
            (number->string (inexact->exact (round (/ count elapsed))))
            " links/s\n"))))

;; ── Benchmark 3: Query performance ──
(display "\n--- Benchmark 3: Simple Query ---\n")
(let* ((start (gettimeofday))
       (iterations 100))
    (do ((i 0 (+ i 1)))
        ((>= i iterations))
        (cog-execute! (Get
            (Inheritance (Variable "$x") (Concept "bench-b-0")))))
    (let* ((end (gettimeofday))
           (elapsed (- (car end) (car start))))
        (display (string-append "Ran " (number->string iterations)
            " queries in " (number->string elapsed) "s\n"))
        (display (string-append "Query rate: "
            (number->string (inexact->exact (round (/ iterations elapsed))))
            " q/s\n"))))

(display "\n=== Benchmark Complete ===\n")
(display (string-append "Total atoms: " (number->string (cog-count-atoms)) "\n"))
