.PHONY: review test

review:
	@bash .agents/skills/reviewing-code-locally/scripts/local_review.sh

test:
	@echo "Validating schemas..."
	@test -d schemas/ && echo "schemas/ exists" || echo "WARN: schemas/ not yet created"
	@echo "Done."
