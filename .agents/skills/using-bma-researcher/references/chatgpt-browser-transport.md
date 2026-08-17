# ChatGPT browser transport adapter

Use this only for the exact `https://chatgpt.com` tab selected by the current
route requirements. It is a foreground adapter, not a controller or retry loop.

## Native upload

ChatGPT always uses `native_file_upload`; never type provider-input bytes into
its composer. X/Grok retains its separate bounded inline route.

1. Hash and count the exact owner-private `provider-input.md` before browser
   work. Require its values to match route requirements.
2. On the selected ChatGPT tab, require exactly one generic
   `input[type="file"]:not([accept])`.
3. Open `Add files and more` and require the visible `Upload from computer`
   action. This current ChatGPT UI state is required before input activation.
4. Pre-arm `tab.playwright.waitForEvent("filechooser", {timeoutMs: 10000})`.
5. Through that tab's `cdp` capability, call `Runtime.evaluate` with
   `userGesture: true` and the exact expression
   `document.querySelector('input[type="file"]:not([accept])').click(); true`.
   This performs one trusted activation of the existing input; it must not edit
   DOM, cookies, account state, or page content.
6. Await the chooser and call `setFiles` once with the absolute path to that
   exact run's `provider-input.md`. Record
   `chooser_selected_prepared_input_match: true` only when the selected path is
   that exact prepared path and its bytes/hash still match route requirements.
7. Require exactly one completed, unambiguous attachment. ChatGPT may display a
   positive-integer duplicate suffix such as `provider-input(1).md`; record the
   complete visible attachment-name inventory and count. Require exactly one
   name and count `1`; record the filename match as true for either the exact
   basename or that bounded suffix, and false for any unrelated label. The exact chooser-selected absolute path
   and prepared hash/bytes must independently bind the upload. Fill
   the composer once with exactly `Use the attached provider-input.md as the
   complete request.` Require exact readback, no other composer text, no
   `[Truncated]`, and an enabled send control before preflight.

The chooser, attachment, and enabled Send prove browser control only. They do
not prove provider attention, extraction, semantic use, or a completed send.
Do not send a `transport-probe` fixture.

## Browser-rendered capture fallback

Use this fallback only when the completed response has no native Markdown export
and the current compound-citation carousel cannot satisfy the strict
all-members drawer model. Bind the exact assistant response subtree and save its
Playwright browser `innerText` bytes and exact `outerHTML`. Enumerate only that response's citation controls in DOM order;
traverse each current compound carousel once in displayed order and save the
first-seen exact HTTPS URLs as an ordered JSON array without normalization.
Retain the response-local source-index or direct-link traversal that produced
that URL list as a separate owner-private JSON file.
The exact schemas and examples live in `SKILL.md`: Deep Research uses the
contiguous indexed row array (`index`, `urls`, `text`); Pro may use that form or
the exact direct-link object (`conversation_url`, `links`, `portable_urls`).
Collect it in the same fixed response-root evaluation, add no fields, and allow
the materializer to regard a raw href and separately retained portable locator
as equivalent only when their sole difference is ChatGPT's terminal
`utm_source=chatgpt.com` query component. Neither retained value is rewritten.
Create the v1 attempt-bound response-root evidence DOM described in `SKILL.md`
from those exact three byte sequences. The runtime parses its root attributes
and rejects a wrong attempt, duplicate evidence marker, or mismatched staged
text/URL bytes. This remains producer-declared evidence, not browser attestation
or proof against deliberate fabrication.
Run `bma-researcher materialize-browser-rendered-capture` once per capture-local
materialization attempt with the citation-free capture draft, exact text, URL
list, traversal, and evidence DOM owner-private files, including
`--citation-traversal <response-local-traversal-json>`. Package only
the emitted `capture-browser-rendered.json`; package revalidates its hash-bound
private materialization inputs and rejects a caller-authored substitute. The
portable occurrence map binds Deep Research numbered marker spans to retained
source indexes or Pro line-bounded marker spans to response-local link anchors.
Missing indexes, nonportable attachment references, and visible `+N` members
without retained locators remain partial; the map proves neither entailment,
compound-member completeness, nor provider-UI completeness. A
pre-emission local validation failure may be corrected in capture-local staging
and rematerialized against the same completed response; never rerun after
successful emission. Do not use clipboard text, manually
rebuild report Markdown, hand-author citation rows, or claim a native export.
