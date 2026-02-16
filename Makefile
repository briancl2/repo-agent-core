.PHONY: review test validate-schemas install-hooks help

# Default target
help:
	@echo "repo-agent-core — Shared primitives for the repo-agent fleet"
	@echo ""
	@echo "Targets:"
	@echo "  make review           Run code review on staged changes"
	@echo "  make test             Run all tests (schemas + samples)"
	@echo "  make validate-schemas Validate all JSON schemas"
	@echo "  make install-hooks    Install git hooks into a target repo"
	@echo "                        Usage: make install-hooks TARGET=~/repos/my-repo"

review:
	@bash .agents/skills/reviewing-code-locally/scripts/local_review.sh

test:
	@bash tests/test-schemas.sh

validate-schemas:
	@echo "=== Validating JSON Schemas ==="
	@for s in schemas/*.schema.json; do \
		python3 -c "import json; json.load(open('$$s'))" && echo "  ✓ $$(basename $$s)" || echo "  ✗ $$(basename $$s)"; \
	done

install-hooks:
	@bash scripts/install-hooks.sh $(TARGET)
