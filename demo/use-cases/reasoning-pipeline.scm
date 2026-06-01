;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; OpenCog AtomSpace — Multi-Step Reasoning Pipeline
;; Complex reasoning chain across multiple domains
;;
;; Usage: cat demo/use-cases/reasoning-pipeline.scm | nc localhost 17001

;; ── Step 1: Taxonomy ──
(Concept "poodle")  (Concept "golden-retriever")  (Concept "beagle")
(Concept "dog")     (Concept "mammal")             (Concept "animal")
(Concept "pet")     (Concept "working-dog")

(Inheritance (Concept "poodle")           (Concept "dog"))
(Inheritance (Concept "golden-retriever") (Concept "dog"))
(Inheritance (Concept "beagle")           (Concept "dog"))
(Inheritance (Concept "dog")              (Concept "mammal"))
(Inheritance (Concept "mammal")           (Concept "animal"))

;; ── Step 2: Properties ──
(Predicate "temperament")  (Predicate "size")  (Predicate "lifespan")
(Predicate "shedding")     (Predicate "trainability")

(Evaluation (Predicate "temperament")   (List (Concept "poodle")           (Concept "intelligent")))
(Evaluation (Predicate "temperament")   (List (Concept "golden-retriever") (Concept "friendly")))
(Evaluation (Predicate "size")          (List (Concept "poodle")           (Concept "small")))
(Evaluation (Predicate "size")          (List (Concept "golden-retriever") (Concept "large")))
(Evaluation (Predicate "lifespan")      (List (Concept "poodle")           (Number 14)))
(Evaluation (Predicate "lifespan")      (List (Concept "beagle")           (Number 13)))
(Evaluation (Predicate "shedding")      (List (Concept "poodle")           (Concept "low")))
(Evaluation (Predicate "trainability")  (List (Concept "poodle")           (Concept "high")))

;; ── Step 3: Rule: every dog is loyal ──
(cog-execute! (Bind
    (Inheritance (Variable "$X") (Concept "dog"))
    (Evaluation (Predicate "loyal") (List (Variable "$X") (Concept "true")))))

;; ── Step 4: Rule: every mammal is warm-blooded ──
(cog-execute! (Bind
    (Inheritance (Variable "$X") (Concept "mammal"))
    (Evaluation (Predicate "warm-blooded") (List (Variable "$X") (Concept "true")))))

;; ── Step 5: Cross-domain query ──
(display "\n=== All inferred properties of poodle ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "$prop") (List (Concept "poodle") (Variable "$val")))))

(display "\n=== All dogs with their sizes ===\n")
(cog-execute! (Get
    (And (Inheritance (Variable "$d") (Concept "dog"))
         (Evaluation (Predicate "size") (List (Variable "$d") (Variable "$s"))))))

(display "\n=== Small dogs with high trainability ===\n")
(cog-execute! (Get
    (And (Inheritance (Variable "$d") (Concept "dog"))
         (Evaluation (Predicate "size") (List (Variable "$d") (Concept "small")))
         (Evaluation (Predicate "trainability") (List (Variable "$d") (Concept "high"))))))

(display "\n=== Loyal, warm-blooded animals ===\n")
(cog-execute! (Get
    (And (Evaluation (Predicate "loyal") (List (Variable "$x") (Concept "true")))
         (Evaluation (Predicate "warm-blooded") (List (Variable "$x") (Concept "true"))))))
