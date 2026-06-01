;; OpenCog AtomSpace — Temporal Reasoning Demo
;; Model events, times, and sequences
;;
;; Usage: cat demo/use-cases/temporal.scm | nc localhost 17001

(Concept "morning-standup")
(Concept "code-review")
(Concept "lunch")
(Concept "sprint-planning")

(AtTime (Concept "morning-standup")   (Time "2026-06-01T09:00:00"))
(AtTime (Concept "code-review")       (Time "2026-06-01T10:00:00"))
(AtTime (Concept "lunch")             (Time "2026-06-01T12:00:00"))
(AtTime (Concept "sprint-planning")   (Time "2026-06-01T14:00:00"))

(Before (Time "2026-06-01T09:00:00") (Time "2026-06-01T10:00:00"))
(Before (Time "2026-06-01T10:00:00") (Time "2026-06-01T12:00:00"))
(Before (Time "2026-06-01T12:00:00") (Time "2026-06-01T14:00:00"))

(display "\n=== Events at 10:00 ===\n")
(cog-execute! (Get (AtTime (Variable "$e") (Time "2026-06-01T10:00:00"))))

(display "\n=== Morning events (before 12:00) ===\n")
(cog-execute! (Get
    (And (AtTime (Variable "$e") (Variable "$t"))
         (Before (Variable "$t") (Time "2026-06-01T12:00:00")))))
