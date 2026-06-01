;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; OpenCog AtomSpace — Cooking Knowledge Base
;; Recipes, ingredients, and dietary rules
;;
;; Usage: cat demo/use-cases/recipe-knowledge.scm | nc localhost 17001

;; ── Ingredients ──
(Concept "flour") (Concept "eggs") (Concept "milk")
(Concept "sugar") (Concept "butter") (Concept "chocolate")
(Concept "tomato") (Concept "cheese") (Concept "pasta")
(Concept "olive-oil") (Concept "garlic") (Concept "basil")

;; ── Categories ──
(Concept "vegetarian") (Concept "vegan") (Concept "dessert")
(Concept "savory") (Concept "italian") (Concept "baking")

;; ── Recipes ──
(Concept "pasta-aglio-olio")
(Concept "chocolate-cake")
(Concept "tomato-sauce")

;; Recipe ingredients
(Evaluation (Predicate "requires") (List (Concept "pasta-aglio-olio") (Concept "pasta")))
(Evaluation (Predicate "requires") (List (Concept "pasta-aglio-olio") (Concept "olive-oil")))
(Evaluation (Predicate "requires") (List (Concept "pasta-aglio-olio") (Concept "garlic")))

(Evaluation (Predicate "requires") (List (Concept "chocolate-cake") (Concept "flour")))
(Evaluation (Predicate "requires") (List (Concept "chocolate-cake") (Concept "eggs")))
(Evaluation (Predicate "requires") (List (Concept "chocolate-cake") (Concept "sugar")))
(Evaluation (Predicate "requires") (List (Concept "chocolate-cake") (Concept "butter")))
(Evaluation (Predicate "requires") (List (Concept "chocolate-cake") (Concept "chocolate")))

(Evaluation (Predicate "requires") (List (Concept "tomato-sauce") (Concept "tomato")))
(Evaluation (Predicate "requires") (List (Concept "tomato-sauce") (Concept "garlic")))
(Evaluation (Predicate "requires") (List (Concept "tomato-sauce") (Concept "olive-oil")))
(Evaluation (Predicate "requires") (List (Concept "tomato-sauce") (Concept "basil")))

;; Recipe categories
(Member (Concept "pasta-aglio-olio") (Concept "vegetarian"))
(Member (Concept "pasta-aglio-olio") (Concept "vegan"))
(Member (Concept "pasta-aglio-olio") (Concept "italian"))
(Member (Concept "chocolate-cake")  (Concept "dessert"))
(Member (Concept "chocolate-cake")  (Concept "baking"))
(Member (Concept "tomato-sauce")    (Concept "vegetarian"))
(Member (Concept "tomato-sauce")    (Concept "vegan"))
(Member (Concept "tomato-sauce")    (Concept "italian"))

;; ── Queries ──
(display "\n=== Vegan recipes ===\n")
(cog-execute! (Get (Member (Variable "$r") (Concept "vegan"))))

(display "\n=== What does chocolate-cake need? ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "requires") (List (Concept "chocolate-cake") (Variable "$i")))))

(display "\n=== Desserts and their ingredients ===\n")
(cog-execute! (Get
    (And (Member (Variable "$r") (Concept "dessert"))
         (Evaluation (Predicate "requires") (List (Variable "$r") (Variable "$i"))))))
