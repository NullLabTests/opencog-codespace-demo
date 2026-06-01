;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; OpenCog AtomSpace — FloatValue, StringValue, and LinkValue Demo
;; Demonstrates attaching arbitrary values to atoms
;;
;; Usage: cat demo/values-api.scm | nc localhost 17001

(display "=== Value System Exploration ===\n\n")

(define sensor (Concept "temperature-sensor"))
(define greeting (Concept "greeting-message"))
(define book (Concept "book"))

;; FloatValue
(display "--- FloatValue ---\n")
(cog-set-value! sensor (Predicate "celsius") (FloatValue 22.5))
(cog-set-value! sensor (Predicate "fahrenheit") (FloatValue 72.5))
(cog-set-value! sensor (Predicate "humidity") (FloatValue 0.65))

(display "Temperature: ")
(display (cog-value sensor (Predicate "celsius")))
(newline)

;; StringValue
(display "\n--- StringValue ---\n")
(cog-set-value! greeting (Predicate "hello") (StringValue "Hello, AtomSpace!"))
(cog-set-value! greeting (Predicate "goodbye") (StringValue "See you later!"))

(display "Greeting: ")
(display (cog-value greeting (Predicate "hello")))
(newline)

;; Multiple values on one atom
(display "\n--- All values on sensor atom ---\n")
(cog-set-value! sensor (Predicate "name") (StringValue "DHT22"))
(cog-set-value! sensor (Predicate "pin") (FloatValue 4))

;; Get all keys
(display "sensor has values for predicates: celsius, fahrenheit, humidity, name, pin\n")

;; TruthValue (built-in)
(display "\n--- TruthValue (built-in) ---\n")
(cog-set-tv! book (cog-new-stv 0.8 0.9))
(display "book truth value: ")
(display (cog-tv book))
(newline)

(display "\nValue system demo complete.\n")
