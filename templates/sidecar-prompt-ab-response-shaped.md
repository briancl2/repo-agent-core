# Standalone External-Intelligence Sidecar Prompt

You are an external intelligence receiving a standalone prompt. Execute the task
in this prompt; the prompt text is not the object of review.

You do not have local filesystem access, private repository access, GitHub issue
access, prior chat access, or workspace context beyond what is embedded below.

Use only the embedded context as required context. Public URLs, if included, are
optional and non-load-bearing; they may help research, but they are not required
to understand or answer the task.

## Mode

Choose exactly one mode for the sidecar turn:

- Singleton: one-pass advisory review or problem-solving.
- Prompt A: first pass that asks clarifying questions, context gaps,
  assumptions, and evidence needed for Prompt B.
- Prompt B: second pass that embeds actual Prompt A output plus answered context
  before asking for the final answer.
- Deep Research: research pass with research targets, source rules, and a
  source-ledger response shape.

Selected mode:

## Purpose

State the sidecar's goal in plain language.

## Definitions And Glossary

Define project names, acronyms, tools, architecture terms, mechanism names,
principles, integration points, and any shorthand used below.

## Embedded Context

Embed the full context needed for the external model to reason without local
files, private repositories, GitHub issues, prior chats, or hidden workspace
knowledge. Include the architecture, principles, goals, relevant evidence
summary, known failure modes, constraints, and what success should look like.

## Optional Non-Load-Bearing Public Sources

List public URLs only when they are optional starting points. Do not put required
context only behind a link.

## Prompt A Instructions

Use this section only for Prompt A mode. Ask for clarifying questions, context
gaps, assumptions to confirm, evidence to embed in Prompt B, and terms that need
clearer definitions. Do not ask for the final answer in Prompt A.

## Actual Prompt A Output

Use this section only for Prompt B mode. Embed the actual Prompt A output here.
Do not use placeholders.

## Answered Context For Prompt B

Use this section only for Prompt B mode. Embed the operator or coordinator
answers to Prompt A here. Do not use placeholders.

## Research Targets

Use this section only for Deep Research mode. Name the research questions,
target domains, source priorities, and decision the research should support.

## Source Rules

Use this section only for Deep Research mode. State public-source boundaries,
source quality preferences, citation expectations, and source-ledger fields.

## Response Shape

Name the exact sections the external model should return. Include Prompt A
reconciliation for Prompt B mode and a source ledger for Deep Research mode.

## Boundary

This sidecar output is advisory. It does not close GitHub issues, approve pull
requests, mutate repositories, replace operator judgment, or become task closure
truth. It does not authorize automation, controllers, schedulers, queues,
daemons, registries, retry loops, automatic GitHub mutation, auto-merge, or
background memory behavior.
