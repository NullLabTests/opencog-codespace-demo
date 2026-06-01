;; ── Game Rule Engine Demo ──
;; Demonstrates rule-based game logic using ImplicationLinks
;; Usage: cat demo/use-cases/game-rule-engine.scm | nc localhost 17001

(use-modules (opencog))

(display "=== Game Rule Engine ===\n")

;; ── Create game items ──
(Concept "sword")
(Concept "shield")
(Concept "potion")
(Concept "monster")
(Concept "treasure")
(Concept "player")

;; Give items properties
(Evaluation (Predicate "attack") (List (Concept "sword") (Number 15)))
(Evaluation (Predicate "defense") (List (Concept "shield") (Number 10)))
(Evaluation (Predicate "heal") (List (Concept "potion") (Number 25)))
(Evaluation (Predicate "health") (List (Concept "monster") (Number 50)))

;; Player starts with sword
(Evaluation (Predicate "has-item") (List (Concept "player") (Concept "sword")))

;; ── Define game rules as ImplicationLinks ──

;; Rule 1: If player has sword and monster is present, player can attack
(Implication
    (And
        (Evaluation (Predicate "has-item") (List (Concept "player") (Concept "sword")))
        (Evaluation (Predicate "health") (List (Concept "monster") (Variable "$h"))))
    (Evaluation (Predicate "can-attack") (List (Concept "player") (Concept "monster"))))

;; Rule 2: If player can attack, monster takes damage
(Implication
    (Evaluation (Predicate "can-attack") (List (Concept "player") (Concept "monster")))
    (Evaluation (Predicate "health") (List (Concept "monster") (Number 35))))

;; ── Query what rules apply ──
(display "\n=== Checking Rules ===\n")

;; Does player have a sword?
(display "Player has item 'sword':\n")
(cog-execute!
    (Get (Evaluation (Predicate "has-item")
        (List (Concept "player") (Concept "sword")))))

;; What attacks are possible?
(display "\nPossible attacks:\n")
(cog-execute!
    (Get (Evaluation (Predicate "can-attack")
        (List (Concept "player") (Variable "$target")))))

(display "\nDone.\n")
