;; OpenCog AtomSpace — REST API Integration Demo
;; Demonstrate using the CogServer's HTTP endpoint
;;
;; Usage: This demo uses curl, not nc. Run each section manually.
;;
;;   curl -s http://localhost:18080/stats | python3 -m json.tool
;;
;; The REST API is read-only (stats, status). For mutations,
;; use the WebSocket JSON protocol.

(display "=== REST API Integration Demo ===\n\n")
(display "The CogServer exposes a read-only HTTP API on port 18080.\n")
(display "Endpoints:\n")
(display "  GET /stats      — Server status, modules, connections\n")
(display "  GET /           — Root (redirects to visualizer)\n")
(display "\nTo query from the command line:\n")
(display "  curl -s http://localhost:18080/stats | python3 -m json.tool\n")
(display "\nFor write operations, use the WebSocket JSON protocol:\n")
(display "  ws://localhost:18080/json\n")
(display "  Payload: {\"command\": \"scheme\", \"body\": \"(Concept \\\"test\\\")\"}\n")
