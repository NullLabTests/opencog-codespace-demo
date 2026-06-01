;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; OpenCog AtomSpace — Music Theory Knowledge Base
;; Notes, scales, chords, and their relationships
;;
;; Usage: cat demo/use-cases/music-theory.scm | nc localhost 17001

;; ── Notes ──
(Concept "C") (Concept "D") (Concept "E") (Concept "F")
(Concept "G") (Concept "A") (Concept "B")
(Concept "C#")(Concept "F#")(Concept "Bb")

;; ── Note properties ──
(Evaluation (Predicate "is-natural") (List (Concept "C") (Concept "true")))
(Evaluation (Predicate "is-natural") (List (Concept "D") (Concept "true")))
(Evaluation (Predicate "is-natural") (List (Concept "E") (Concept "true")))
(Evaluation (Predicate "is-sharp")   (List (Concept "C#") (Concept "true")))
(Evaluation (Predicate "is-flat")    (List (Concept "Bb") (Concept "true")))

;; ── Intervals ──
(Evaluation (Predicate "interval") (List (Concept "C") (Concept "D") (Number 2)))
(Evaluation (Predicate "interval") (List (Concept "C") (Concept "E") (Number 4)))
(Evaluation (Predicate "interval") (List (Concept "C") (Concept "G") (Number 7)))
(Evaluation (Predicate "interval") (List (Concept "C") (Concept "A") (Number 9)))

;; ── Scales ──
(Concept "C-major")
(Concept "G-major")
(Concept "A-minor")

(Member (Concept "C") (Concept "C-major"))
(Member (Concept "D") (Concept "C-major"))
(Member (Concept "E") (Concept "C-major"))
(Member (Concept "F") (Concept "C-major"))
(Member (Concept "G") (Concept "C-major"))
(Member (Concept "A") (Concept "C-major"))
(Member (Concept "B") (Concept "C-major"))

;; G major has one sharp
(Member (Concept "G")  (Concept "G-major"))
(Member (Concept "A")  (Concept "G-major"))
(Member (Concept "B")  (Concept "G-major"))
(Member (Concept "C")  (Concept "G-major"))
(Member (Concept "D")  (Concept "G-major"))
(Member (Concept "E")  (Concept "G-major"))
(Member (Concept "F#") (Concept "G-major"))

;; ── Chords ──
(Concept "C-major-chord")
(Concept "C-minor-chord")
(Concept "G-major-chord")

(Member (Concept "C") (Concept "C-major-chord"))
(Member (Concept "E") (Concept "C-major-chord"))
(Member (Concept "G") (Concept "C-major-chord"))

(Member (Concept "C") (Concept "C-minor-chord"))
(Member (Concept "Eb") (Concept "C-minor-chord"))
(Member (Concept "G")  (Concept "C-minor-chord"))

;; ── Queries ──
(display "\n=== Notes in C major scale ===\n")
(cog-execute! (Get (Member (Variable "$n") (Concept "C-major"))))

(display "\n=== Notes in G major scale (has F#) ===\n")
(cog-execute! (Get (Member (Variable "$n") (Concept "G-major"))))

(display "\n=== Notes in C major chord ===\n")
(cog-execute! (Get (Member (Variable "$n") (Concept "C-major-chord"))))

(display "\n=== Intervals from C ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "interval") (List (Concept "C") (Variable "$n") (Variable "$i")))))
