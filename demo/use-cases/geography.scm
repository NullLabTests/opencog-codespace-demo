;; OpenCog AtomSpace — World Geography Knowledge Base
;; Countries, capitals, continents, and relationships
;;
;; Usage: cat demo/use-cases/geography.scm | nc localhost 17001

;; ── Continents ──
(Concept "europe") (Concept "asia") (Concept "north-america")
(Concept "south-america") (Concept "africa") (Concept "australia")

;; ── Countries ──
(Concept "france") (Concept "japan") (Concept "brazil")
(Concept "usa")    (Concept "egypt") (Concept "australia-country")
(Concept "china")  (Concept "india") (Concept "germany")

;; ── Capitals ──
(Concept "paris") (Concept "tokyo") (Concept "brasilia")
(Concept "washington-dc") (Concept "cairo") (Concept "canberra")
(Concept "beijing") (Concept "new-delhi") (Concept "berlin")

;; ── Continent membership ──
(Member (Concept "france") (Concept "europe"))
(Member (Concept "germany")(Concept "europe"))
(Member (Concept "japan")  (Concept "asia"))
(Member (Concept "china")  (Concept "asia"))
(Member (Concept "india")  (Concept "asia"))
(Member (Concept "brazil") (Concept "south-america"))
(Member (Concept "usa")    (Concept "north-america"))
(Member (Concept "egypt")  (Concept "africa"))
(Member (Concept "australia-country") (Concept "australia"))

;; ── Capitals ──
(Evaluation (Predicate "capital") (List (Concept "france") (Concept "paris")))
(Evaluation (Predicate "capital") (List (Concept "japan")  (Concept "tokyo")))
(Evaluation (Predicate "capital") (List (Concept "brazil") (Concept "brasilia")))
(Evaluation (Predicate "capital") (List (Concept "usa")    (Concept "washington-dc")))
(Evaluation (Predicate "capital") (List (Concept "egypt")  (Concept "cairo")))
(Evaluation (Predicate "capital") (List (Concept "australia-country") (Concept "canberra")))
(Evaluation (Predicate "capital") (List (Concept "china")  (Concept "beijing")))
(Evaluation (Predicate "capital") (List (Concept "india")  (Concept "new-delhi")))
(Evaluation (Predicate "capital") (List (Concept "germany")(Concept "berlin")))

;; ── Population (simple categories) ──
(Evaluation (Predicate "population") (List (Concept "china") (Concept "huge")))
(Evaluation (Predicate "population") (List (Concept "india") (Concept "huge")))
(Evaluation (Predicate "population") (List (Concept "usa")   (Concept "large")))
(Evaluation (Predicate "population") (List (Concept "france")(Concept "medium")))
(Evaluation (Predicate "population") (List (Concept "egypt") (Concept "medium")))

;; ── Queries ──
(display "\n=== European countries ===\n")
(cog-execute! (Get (Member (Variable "$c") (Concept "europe"))))

(display "\n=== Asian capitals ===\n")
(cog-execute! (Get
    (And (Member (Variable "$c") (Concept "asia"))
         (Evaluation (Predicate "capital") (List (Variable "$c") (Variable "$cap"))))))

(display "\n=== Countries with huge population ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "population") (List (Variable "$c") (Concept "huge")))))

(display "\n=== All capitals ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "capital") (List (Variable "$country") (Variable "$city")))))
