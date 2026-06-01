;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; OpenCog AtomSpace — Semantic Network + Syllogism Demo
;; Classic Socrates mortality example
;;
;; Usage: cat demo/use-cases/semantic-net.scm | nc localhost 17001

(Concept "Socrates")
(Concept "Plato")
(Concept "Aristotle")
(Concept "philosopher")
(Concept "greek")
(Concept "human")
(Concept "mortal")

(Inheritance (Concept "Socrates")  (Concept "philosopher"))
(Inheritance (Concept "Plato")     (Concept "philosopher"))
(Inheritance (Concept "Aristotle") (Concept "philosopher"))
(Inheritance (Concept "Socrates")  (Concept "greek"))
(Inheritance (Concept "philosopher") (Concept "human"))
(Inheritance (Concept "human")     (Concept "mortal"))

(display "\n=== All mortals ===\n")
(cog-execute! (Get (Inheritance (Variable "$x") (Concept "mortal"))))

(display "\n=== Greek philosophers ===\n")
(cog-execute! (Get
    (And (Inheritance (Variable "$x") (Concept "philosopher"))
         (Inheritance (Variable "$x") (Concept "greek")))))
