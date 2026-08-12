.PHONY: review test validate-schemas validate-owner-convergence validate-compare-scorecards validate-bma-researcher-skill install-hooks help

OWNER_CONVERGENCE_BASE_REF ?= $(shell if git diff --cached --quiet --; then printf 'HEAD^'; else printf 'HEAD'; fi)

# Default target
help:
	@echo "repo-agent-core — Shared primitives for the repo-agent fleet"
	@echo ""
	@echo "Targets:"
	@echo "  make review           Run code review on staged changes"
	@echo "  make test             Run all tests (schemas + samples)"
	@echo "  make validate-owner-convergence"
	@echo "                        Validate cached-index owner package convergence"
	@echo "  make validate-schemas Validate all JSON schemas"
	@echo "  make validate-compare-scorecards"
	@echo "                        Validate compare-scorecards copy-sync drift gate"
	@echo "                        Usage: make validate-compare-scorecards CONSUMERS=\"../repo-auditor ../repo-optimizer\""
	@echo "  make validate-bma-researcher-skill"
	@echo "                        Validate portable Researcher skill/install behavior"
	@echo "  make install-hooks    Install git hooks into a target repo"
	@echo "                        Usage: make install-hooks TARGET=~/repos/my-repo"

review:
	@bash .agents/skills/reviewing-code-locally/scripts/local_review.sh

test:
	@echo "=== Running core test suite ==="
	@$(MAKE) --no-print-directory validate-owner-convergence
	@for t in tests/test-*.sh; do \
		echo "--- $$t ---"; bash "$$t" || exit 1; \
	done
	@echo ""
	@echo "=== All tests passed ==="

validate-schemas:
	@echo "=== Validating JSON Schemas ==="
	@for s in schemas/*.schema.json; do \
		python3 -c "import json; json.load(open('$$s'))" && echo "  ✓ $$(basename $$s)" || echo "  ✗ $$(basename $$s)"; \
	done

validate-owner-convergence:
	@python3 scripts/validate_owner_convergence.py --repo . \
		--base-ref "$(OWNER_CONVERGENCE_BASE_REF)"

validate-compare-scorecards:
	@echo "=== Validating compare-scorecards distribution model ==="
	@bash tests/test-compare-scorecards.sh
	@if [ -n "$(CONSUMERS)" ]; then \
		bash scripts/check-compare-scorecards-conformance.sh $(CONSUMERS); \
	else \
		echo "No CONSUMERS provided; synthetic copy-sync drift-gate tests only."; \
	fi

validate-bma-researcher-skill:
	@bash tests/test-using-bma-researcher.sh

install-hooks:
	@bash scripts/install-hooks.sh $(TARGET)
