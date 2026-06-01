REPL_PORT ?= 17001
WEB_PORT  ?= 18080
MCP_PORT  ?= 18888
COGSERVER ?= $(shell command -v cogserver 2>/dev/null || echo /usr/local/bin/cogserver)

.PHONY: help start stop restart status test clean

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

start: ## Start the CogServer
	@echo "Starting CogServer on ports $(REPL_PORT) (REPL) / $(WEB_PORT) (Web) / $(MCP_PORT) (MCP)..."
	@nohup "$(COGSERVER)" -p "$(REPL_PORT)" -w "$(WEB_PORT)" -m "$(MCP_PORT)" > /tmp/cogserver.log 2>&1 &
	@sleep 1
	@if pgrep cogserver > /dev/null 2>&1; then \
		echo "CogServer started (PID $$(pgrep cogserver))."; \
	else \
		echo "ERROR: CogServer failed to start."; \
		exit 1; \
	fi

stop: ## Stop the CogServer
	@if pgrep cogserver > /dev/null 2>&1; then \
		echo "Stopping CogServer (PID $$(pgrep cogserver))..."; \
		pkill cogserver 2>/dev/null || true; \
		sleep 1; \
		echo "Stopped."; \
	else \
		echo "CogServer is not running."; \
	fi

restart: stop start ## Restart the CogServer

status: ## Check CogServer status
	@if pgrep cogserver > /dev/null 2>&1; then \
		echo "CogServer is running (PID $$(pgrep cogserver))."; \
		echo "  REPL:  lsof -i :$(REPL_PORT)"; \
		echo "  Web:   http://localhost:$(WEB_PORT)/visualizer/"; \
		echo "  MCP:   lsof -i :$(MCP_PORT)"; \
	else \
		echo "CogServer is NOT running."; \
	fi

test: ## Run the comprehensive demo script
	@echo "Running comprehensive demo..."
	@cat demo/comprehensive-demo.scm | nc -w 10 localhost $(REPL_PORT) 2>/dev/null | tail -5
	@echo "Demo complete."

test-quick: ## Run the quick demo script
	@echo "Running quick demo..."
	@cat demo.scm | nc -w 10 localhost $(REPL_PORT) 2>/dev/null

test-repl: ## Test REPL connectivity
	@echo '(+ 1 2)' | nc -w 5 localhost $(REPL_PORT) 2>/dev/null | grep -q '3' && \
		echo "REPL test PASSED" || echo "REPL test FAILED (is CogServer running?)"

test-http: ## Test HTTP endpoint
	@curl -sf http://localhost:$(WEB_PORT)/stats > /dev/null 2>&1 && \
		echo "HTTP test PASSED" || echo "HTTP test FAILED"

clean: ## Clean temporary files
	@rm -f /tmp/cogserver.log
	@echo "Cleaned."

docker-build: ## Build Docker image
	docker build -t opencog-demo .

docker-run: ## Run Docker container
	docker run -it --rm -p $(REPL_PORT):$(REPL_PORT) -p $(WEB_PORT):$(WEB_PORT) opencog-demo

count: ## Count lines of code in the repo
	@find . -name '*.scm' -o -name '*.md' -o -name '*.yml' -o -name '*.py' | \
		xargs wc -l | tail -1
