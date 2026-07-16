---
description: Route constitutional changes to exact-byte root ratification while preserving the Spec Kit pointer.
handoffs:
  - label: Build Specification
    agent: speckit.specify
    prompt: Implement the feature specification within the ratified constitution and owner policy. I want to build...
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Constitutional boundary

1. Read root `CONSTITUTION.md`, root `AGENTS.md`, and
   `.specify/memory/constitution.md` before acting.
2. Treat `CONSTITUTION.md` as the only shared constitution and
   `.specify/memory/constitution.md` as a pointer to it. Never recreate, amend,
   version, summarize, or extend a second constitution in `.specify`.
3. Route owner-local specialization to `AGENTS.md` or the applicable subordinate
   contract. Owner policy may strengthen or specialize the root floor but may
   not weaken it or create additional shared constitutional meaning.
4. A request that changes shared constitutional meaning requires explicit
   operator ratification of proposed exact, hash-identified root bytes. Until
   that authority is present, do not edit the root file; report the proposed
   bytes and hash or the unresolved conflict instead.
5. After an authorized root amendment, preserve
   `.specify/memory/constitution.md` as the concise pointer. Do not prepend a
   sync report or add ratification metadata, placeholders, principles, or
   governance text to the pointer.
6. Review dependent Spec Kit templates only for references that contradict the
   ratified root or owner policy. Do not copy the nine articles into templates
   or invent a second constitutional checklist.

Finish by reporting whether the request was routed to exact-byte root
ratification, subordinate owner policy, or an ordinary specification handoff,
and name any unresolved authority conflict.
