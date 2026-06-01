;; OpenCog AtomSpace — Rule-Based Expert System Demo
;; Diagnostic rules using implication links
;;
;; Usage: cat demo/use-cases/expert-system.scm | nc localhost 17001

(Concept "fever")
(Concept "cough")
(Concept "sore-throat")
(Concept "headache")
(Concept "fatigue")
(Concept "runny-nose")
(Concept "sneezing")
(Concept "common-cold")
(Concept "flu")
(Concept "allergies")

(Implication
    (And (Concept "cough") (Concept "runny-nose") (Concept "sore-throat"))
    (Concept "common-cold"))

(Implication
    (And (Concept "fever") (Concept "cough") (Concept "fatigue") (Concept "headache"))
    (Concept "flu"))

(Implication
    (And (Concept "runny-nose") (Concept "sneezing"))
    (Concept "allergies"))

(Evaluation (Predicate "has-symptom") (List (Concept "patient") (Concept "cough")))
(Evaluation (Predicate "has-symptom") (List (Concept "patient") (Concept "runny-nose")))
(Evaluation (Predicate "has-symptom") (List (Concept "patient") (Concept "sore-throat")))
(Evaluation (Predicate "has-symptom") (List (Concept "patient") (Concept "fatigue")))

(display "\n=== Patient Symptoms ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "has-symptom") (List (Concept "patient") (Variable "$s")))))
