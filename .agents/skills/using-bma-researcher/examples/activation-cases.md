# Activation Cases

## Operator question

Input: “What changed in the primary evidence for this decision, and should I
act?”

Record the sentence exactly, set `trigger` to `operator_question`, choose the
job family from the decision need, and prepare once. Do not append source hints
from prior work.

## Agent-detected need

During an authorized implementation, the agent finds that an upstream behavior
is both consequential and currently uncertain. It records the exact need,
timestamp, `agent_detected_need`, authority, and job family before searching or
freezing context. It does not convert a test idea into a synthetic research need.

## Composite need

A real question asks both whether a claim is true and which option to choose.
Record `investigate_claim` and `compare_options`, name one primary family, and
keep the original question unchanged.

## No action

The cited evidence supports retaining the current decision. Package the report
with outcome `NO_ACTION`, explain what would change that disposition, and do not
invent an implementation task.

## Prior-report reentry

The operator asks for the current decision from a previously admitted report.
Use its opaque admission handle plus the current ordinary question. Render the
answer, residual, next decision, and claim ceiling without relaunching research.

## Invalid activation

A test author proposes a question together with annotated links, expected
sources, and an expected conclusion. Reject preparation because the extra
fields seed relevance. Test the contract with sanitized fixtures instead.
