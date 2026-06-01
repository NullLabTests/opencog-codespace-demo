;; ── CogServer Initialization Script ──
;; Load this to set up modules and defaults on startup
;; Usage: cat init-cogserver.scm | nc localhost 17001

(use-modules (opencog))

(display "=== Initializing CogServer ===\n")

;; Load core modules
(use-modules (opencog query))
(use-modules (opencog exec))

(display "Modules loaded.\n")

;; Create initial knowledge anchors
(Anchor "init-complete")
(Anchor "cogserver-ready")

;; Set system metadata
(cog-set-value! (Anchor "cogserver-ready")
    (Predicate "version")
    (StringValue "OpenCog AtomSpace v5.0.3"))

;; Count initial atoms
(display (string-append "Atom count after init: "
    (number->string (cog-count-atoms)) "\n"))

(display "=== Initialization Complete ===\n")
