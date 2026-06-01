;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; OpenCog AtomSpace — Action Planning
;; Simple planning domain with preconditions and effects
;;
;; Usage: cat demo/use-cases/planning.scm | nc localhost 17001

;; ── State ──
(Concept "room-a") (Concept "room-b") (Concept "room-c")
(Concept "robot")  (Concept "box")    (Concept "key")

;; ── Initial state ──
(Evaluation (Predicate "at") (List (Concept "robot") (Concept "room-a")))
(Evaluation (Predicate "at") (List (Concept "box")   (Concept "room-a")))
(Evaluation (Predicate "at") (List (Concept "key")   (Concept "room-b")))
(Evaluation (Predicate "locked") (List (Concept "box") (Concept "true")))
(Evaluation (Predicate "holds")  (List (Concept "robot") (Concept "nothing")))

;; ── Actions as Implications ──
;; Action: move(robot, X, Y) — robot moves from X to Y
;; Precondition: at(robot, X)
;; Effect: at(robot, Y), not at(robot, X)
(Implication
    (Evaluation (Predicate "at") (List (Concept "robot") (Variable "$from")))
    (Evaluation (Predicate "can-move-to") (List (Concept "robot") (Variable "$to"))))

;; Action: pickup(robot, obj) — robot picks up an object
;; Precondition: at(robot, X), at(obj, X), holds(robot, nothing)
;; Effect: holds(robot, obj)
(Implication
    (And (Evaluation (Predicate "at") (List (Variable "$agent") (Variable "$loc")))
         (Evaluation (Predicate "at") (List (Variable "$obj")  (Variable "$loc")))
         (Evaluation (Predicate "holds") (List (Variable "$agent") (Concept "nothing"))))
    (Evaluation (Predicate "can-pickup") (List (Variable "$agent") (Variable "$obj"))))

;; Action: unlock(robot, box) — unlock box with key
;; Precondition: holds(robot, key), at(box, X), at(robot, X)
;; Effect: locked(box, false)
(Implication
    (And (Evaluation (Predicate "holds") (List (Concept "robot") (Concept "key")))
         (Evaluation (Predicate "at") (List (Concept "box") (Variable "$loc")))
         (Evaluation (Predicate "at") (List (Concept "robot") (Variable "$loc"))))
    (Evaluation (Predicate "can-unlock") (List (Concept "robot") (Concept "box"))))

;; ── Queries ──
(display "\n=== Current state ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "at") (List (Variable "$entity") (Variable "$location")))))

(display "\n=== Possible actions ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "can-move-to") (List (Variable "$agent") (Variable "$dest")))))
