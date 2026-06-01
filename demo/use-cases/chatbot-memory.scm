;; OpenCog AtomSpace — Chatbot Memory
;; Conversational memory using atoms
;;
;; Usage: cat demo/use-cases/chatbot-memory.scm | nc localhost 17001

(Concept "user-alice")
(Concept "session-1")
(Concept "assistant")
(Concept "chatbot")

;; Messages
(Concept "msg-hello")    (Concept "msg-name")  (Concept "msg-color")
(Concept "msg-mood")     (Concept "msg-food")

;; Message content
(Evaluation (Predicate "content") (List (Concept "msg-hello")  (StringValue "Hi there!")))
(Evaluation (Predicate "content") (List (Concept "msg-name")   (StringValue "My name is Alice")))
(Evaluation (Predicate "content") (List (Concept "msg-color")  (StringValue "I like blue")))
(Evaluation (Predicate "content") (List (Concept "msg-mood")   (StringValue "I am happy")))
(Evaluation (Predicate "content") (List (Concept "msg-food")   (StringValue "I love pizza")))

;; Conversation flow
(Evaluation (Predicate "sender") (List (Concept "msg-hello") (Concept "user-alice")))
(Evaluation (Predicate "sender") (List (Concept "msg-name")  (Concept "user-alice")))
(Evaluation (Predicate "sender") (List (Concept "msg-color") (Concept "user-alice")))
(Evaluation (Predicate "sender") (List (Concept "msg-mood")  (Concept "user-alice")))
(Evaluation (Predicate "sender") (List (Concept "msg-food")  (Concept "user-alice")))

;; Temporal order
(Before (Concept "msg-hello") (Concept "msg-name"))
(Before (Concept "msg-name") (Concept "msg-color"))
(Before (Concept "msg-color") (Concept "msg-mood"))
(Before (Concept "msg-mood") (Concept "msg-food"))

;; Facts the chatbot learned
(Evaluation (Predicate "user-name")  (List (Concept "user-alice") (Concept "Alice")))
(Evaluation (Predicate "fav-color")  (List (Concept "user-alice") (Concept "blue")))
(Evaluation (Predicate "mood")       (List (Concept "user-alice") (Concept "happy")))
(Evaluation (Predicate "likes-food") (List (Concept "user-alice") (Concept "pizza")))

(display "\n=== Messages from user-alice ===\n")
(cog-execute! (Get
    (And (Evaluation (Predicate "sender") (List (Variable "$msg") (Concept "user-alice")))
         (Evaluation (Predicate "content") (List (Variable "$msg") (Variable "$text"))))))

(display "\n=== Learned facts about user-alice ===\n")
(cog-execute! (Get
    (Evaluation (Predicate "$fact") (List (Concept "user-alice") (Variable "$value")))))
