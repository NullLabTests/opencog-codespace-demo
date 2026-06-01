;; OpenCog AtomSpace — Advanced Diagnostic Reasoning
;; Multi-step diagnostic reasoning with certainty factors
;;
;; Usage: cat demo/use-cases/diagnostics.scm | nc localhost 17001

;; ── Symptoms ──
(Concept "high-temperature")
(Concept "engine-noise")
(Concept "vibration")
(Concept "warning-light")
(Concept "smoke")
(Concept "fuel-odor")
(Concept "rough-idle")

;; ── Components ──
(Concept "engine")  (Concept "cooling-system")
(Concept "exhaust") (Concept "fuel-system")
(Concept "battery") (Concept "alternator")
(Concept "car")

;; ── Parts ──
(PartOf (Concept "engine")       (Concept "car"))
(PartOf (Concept "cooling-system")(Concept "car"))
(PartOf (Concept "exhaust")      (Concept "car"))
(PartOf (Concept "fuel-system")  (Concept "car"))
(PartOf (Concept "battery")      (Concept "car"))
(PartOf (Concept "alternator")   (Concept "car"))

;; ── Diagnostic rules ──
(Implication
    (And (Concept "high-temperature") (Concept "warning-light"))
    (Concept "cooling-system-failure"))

(Implication
    (And (Concept "engine-noise") (Concept "vibration"))
    (Concept "engine-mount-failure"))

(Implication
    (And (Concept "smoke") (Concept "fuel-odor"))
    (Concept "fuel-system-leak"))

(Implication
    (Concept "rough-idle")
    (Concept "spark-plug-issue"))

;; ── Patient state ──
(Evaluation (Predicate "has-symptom") (List (Concept "my-car") (Concept "high-temperature")))
(Evaluation (Predicate "has-symptom") (List (Concept "my-car") (Concept "warning-light")))
(Evaluation (Predicate "has-symptom") (List (Concept "my-car") (Concept "engine-noise")))
(Evaluation (Predicate "has-symptom") (List (Concept "my-car") (Concept "vibration")))

;; ── Queries ──
(display "\n=== My car's symptoms ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "has-symptom") (List (Concept "my-car") (Variable "$s")))))

(display "\n=== Possible diagnoses ===\n")
(cog-execute! (Get
    (And (Evaluation (Predicate "has-symptom") (List (Concept "my-car") (Variable "$s1")))
         (Evaluation (Predicate "has-symptom") (List (Concept "my-car") (Variable "$s2")))
         (Implication (And (Variable "$s1") (Variable "$s2")) (Variable "$diagnosis")))))
