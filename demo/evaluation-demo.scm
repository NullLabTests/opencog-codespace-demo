;; OpenCog AtomSpace — Neuro-Symbolic AI Example
;; Demonstrate how AtomSpace can work alongside LLMs
;;
;; This script creates a knowledge base that could be queried by
;; an LLM agent, with the LLM results stored back as atoms.
;;
;; Usage: cat demo/evaluation-demo.scm | nc localhost 17001

(display "=== Neuro-Symbolic AI Bridge Demo ===\n\n")

;; ── Knowledge Base (Symbolic) ──
(Concept "transformer")
(Concept "attention-mechanism")
(Concept "neural-network")
(Concept "deep-learning")
(Concept "machine-learning")
(Concept "AI")
(Concept "embedding")
(Concept "token")
(Concept "context-window")

(Inheritance (Concept "transformer")       (Concept "neural-network"))
(Inheritance (Concept "attention-mechanism")(Concept "neural-network"))
(Inheritance (Concept "neural-network")    (Concept "deep-learning"))
(Inheritance (Concept "deep-learning")     (Concept "machine-learning"))
(Inheritance (Concept "machine-learning")  (Concept "AI"))

;; ── Properties (could come from LLM analysis) ──
(Evaluation (Predicate "invented-year")
    (List (Concept "transformer") (Number 2017)))
(Evaluation (Predicate "parameter-count")
    (List (Concept "transformer") (Concept "billions")))
(Evaluation (Predicate "used-for")
    (List (Concept "transformer") (Concept "text-generation")))
(Evaluation (Predicate "used-for")
    (List (Concept "transformer") (Concept "translation")))
(Evaluation (Predicate "used-for")
    (List (Concept "transformer") (Concept "code-generation")))

;; ── Relational Knowledge (LLM-extracted facts) ──
(Evaluation (Predicate "requires")
    (List (Concept "transformer") (Concept "embedding")))
(Evaluation (Predicate "requires")
    (List (Concept "transformer") (Concept "attention-mechanism")))
(Evaluation (Predicate "composed-of")
    (List (Concept "transformer") (Concept "encoder")))
(Evaluation (Predicate "composed-of")
    (List (Concept "transformer") (Concept "decoder")))

;; ── Queries (what an LLM agent might ask) ──
(display "=== Queries: What an LLM agent would ask ===\n\n")

(display "What is transformer a type of?\n")
(cog-execute! (Get (Inheritance (Concept "transformer") (Variable "$x"))))
(newline)

(display "What is transformer used for?\n")
(cog-execute! (Get
    (Evaluation (Predicate "used-for") (List (Concept "transformer") (Variable "$task")))))
(newline)

(display "What does transformer require?\n")
(cog-execute! (Get
    (Evaluation (Predicate "requires") (List (Concept "transformer") (Variable "$component")))))
(newline)

(display "All known facts about transformer:\n")
(cog-execute! (Get
    (Evaluation (Variable "$relation") (List (Concept "transformer") (Variable "$value")))))
(newline)

(display "=== Neuro-Symbolic Bridge Complete ===\n")
(display "An LLM can: query this KB for facts, add new facts via EvaluationLink,\n")
(display "and use InferenceLinks to derive new knowledge.\n")
