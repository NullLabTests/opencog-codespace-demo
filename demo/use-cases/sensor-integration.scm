;; OpenCog AtomSpace Demo
;; SPDX-License-Identifier: Apache-2.0
;; SPDX-FileCopyrightText: 2026 Contributors to OpenCog


;; ── Sensor Integration Demo ──
;; Models sensors, readings, and threshold alerts in Atomese
;; Usage: cat demo/use-cases/sensor-integration.scm | nc localhost 17001

(use-modules (opencog))

(display "=== Sensor Integration Demo ===\n")

;; ── Create sensor nodes ──
(Concept "temperature-sensor-1")
(Concept "humidity-sensor-1")
(Concept "pressure-sensor-1")

;; ── Register sensor types ──
(Evaluation (Predicate "sensor-type")
    (List (Concept "temperature-sensor-1") (Concept "temperature")))
(Evaluation (Predicate "sensor-type")
    (List (Concept "humidity-sensor-1") (Concept "humidity")))
(Evaluation (Predicate "sensor-type")
    (List (Concept "pressure-sensor-1") (Concept "pressure")))

;; ── Create threshold rules ──
;; Temperature > 30C is hot
(Implication
    (GreaterThan
        (Variable "$val") (Number 30))
    (Evaluation (Predicate "alert")
        (List (Concept "temperature-sensor-1") (Concept "hot"))))

;; Humidity > 80% is humid
(Implication
    (GreaterThan
        (Variable "$val") (Number 80))
    (Evaluation (Predicate "alert")
        (List (Concept "humidity-sensor-1") (Concept "humid"))))

;; ── Record sensor readings as values ──
(display "\n=== Recording Sensor Readings ===\n")

(cog-set-value! (Concept "temperature-sensor-1")
    (Predicate "reading") (FloatValue 25.0))
(display "Temp: 25.0 (normal)\n")

(cog-set-value! (Concept "temperature-sensor-1")
    (Predicate "reading") (FloatValue 35.0))
(display "Temp: 35.0 (should trigger hot alert)\n")

(cog-set-value! (Concept "humidity-sensor-1")
    (Predicate "reading") (FloatValue 85.0))
(display "Humidity: 85% (should trigger humid alert)\n")

;; ── Query sensors by type ──
(display "\n=== All Temperature Sensors ===\n")
(cog-execute!
    (Get (Evaluation (Predicate "sensor-type")
        (List (Variable "$sensor") (Concept "temperature")))))

;; ── Query alerts ──
(display "\n=== Active Alerts ===\n")
(cog-execute!
    (Get (Evaluation (Predicate "alert")
        (List (Variable "$sensor") (Variable "$condition")))))

;; ── Query readings ──
(display "\n=== Sensor Readings ===\n")
(cog-execute!
    (Get (Evaluation (Predicate "reading")
        (List (Variable "$sensor") (Variable "$val")))))

(display "\nDone.\n")
