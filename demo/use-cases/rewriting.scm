;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; OpenCog AtomSpace — Graph Rewriting Demo
;; Automatic inference via BindLink rewrite rules
;;
;; Usage: cat demo/use-cases/rewriting.scm | nc localhost 17001

(Concept "poodle")
(Concept "golden-retriever")
(Concept "beagle")
(Concept "dog")
(Concept "pet")
(Concept "loyal")

(Inheritance (Concept "poodle")           (Concept "dog"))
(Inheritance (Concept "golden-retriever") (Concept "dog"))
(Inheritance (Concept "beagle")           (Concept "dog"))
(Inheritance (Concept "dog")              (Concept "pet"))

(display "\n=== Before rewrite: pets ===\n")
(cog-execute! (Get (Inheritance (Variable "$x") (Concept "pet"))))

(display "\n=== Applying rewrite: every dog is loyal ===\n")
(cog-execute! (Bind
    (Inheritance (Variable "$X") (Concept "dog"))
    (Evaluation (Predicate "is-loyal") (List (Variable "$X") (Concept "true")))))

(display "\n=== After rewrite: loyal entities ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "is-loyal") (List (Variable "$x") (Concept "true")))))
