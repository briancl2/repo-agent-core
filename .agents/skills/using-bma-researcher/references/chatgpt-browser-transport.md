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
6. Await the chooser. Re-hash and count that exact run's `provider-input.md`,
   require route-requirements parity, then immediately invoke
   `bma-researcher egress-possible --run-dir <private-run>` and require success.
   This securely creates or revalidates one owner-private conservative event
   before prepared bytes can reach the browser. A failure stops before
   `setFiles`.
7. Call `setFiles` once with the absolute path to that exact
   `provider-input.md`. Record
   `chooser_selected_prepared_input_match: true` only when the selected path is
   that exact prepared path and its bytes/hash still match route requirements.
8. Require exactly one completed, unambiguous attachment. ChatGPT may display a
   positive-integer duplicate suffix such as `provider-input(1).md`; record the
   complete visible attachment-name inventory and count. Require exactly one
   name and count `1`; record the filename match as true for either the exact
   basename or that bounded suffix, and false for any unrelated label. The exact chooser-selected absolute path
   and prepared hash/bytes must independently bind the upload. Fill
   the composer once with exactly `Use the attached provider-input.md as the
   complete request.` Require exact readback, no other composer text, no
   `[Truncated]`, and an enabled send control before preflight.

Reinvoke `egress-possible` immediately before any later supported `setFiles`
call involving those prepared bytes. It revalidates the same event and grants
no retry or send authority. An upload interruption remains `egress_possible`;
it is never evidence of completed transfer or of no disclosure.

The chooser, event, attachment, and enabled Send prove only their separate
bounded properties. They do not prove provider attention, extraction, semantic
use, or a completed send.
Do not send a `transport-probe` fixture.

## Sleep, wake, and connectivity recovery

A confirmed sleep/wake or connectivity break before initial Send activation
invalidates browser handles and the route observation, not known extension
file-URL permission. Once per attempt, discard every stale handle, enumerate
fresh user-owned tabs, and revalidate the same account, entitlement, capability,
attempt, and task-shaped route. This same-route recovery adds no send and allows
no provider, account, model, or route switch. Reopen extension permissions only
when a fresh direct browser error explicitly reports a permission denial. After
Send activation, a confirmed break may reacquire the exact already-sent
conversation and response through fresh user-owned tab and page handles after
reverifying route, conversation, and response identity. This recovery adds no
send. If ChatGPT explicitly reports a connectivity interruption, the response
cannot resume after that recovery, and the newest operator authority explicitly
requests completion, capture-v5 permits one same-route retry with the exact
prepared bytes and fixed instruction. Revalidate the user-owned tab; preserve
provider/account/model/route identity; disclose both sends and the
tab/conversation reset; allow no clarification; and require a completed
captured response. Timeout, stale UI, and ordinary provider failure do not
qualify.

## Browser-rendered capture fallback

Use this fallback only when the completed response has no native Markdown export
and the current compound-citation carousel cannot satisfy the strict
all-members drawer model. Bind the exact assistant response subtree and save its
Playwright browser `innerText` bytes and exact `outerHTML`. Enumerate only that response's citation controls in DOM order;
traverse each current compound carousel once in displayed order and save the
first-seen exact HTTPS URLs as an ordered JSON array without normalization.
Retain the route-specific response-local traversal that produced that URL list
inside the same response-root serialization.
The exact schemas and examples live in `SKILL.md`: Deep Research uses the
contiguous indexed row array (`index`, `urls`, `text`); Pro requires the exact
direct-link object (`conversation_url`, `links`, `portable_urls`). The shapes are
route-exclusive.
Collect it in the same fixed response-root evaluation, add no fields, and allow
the materializer to regard a raw href and separately retained portable locator
as equivalent only when their sole difference is ChatGPT's terminal
`utm_source=chatgpt.com` query component. Neither retained value is rewritten.
Create the v2 attempt-bound response-root evidence DOM described in `SKILL.md`
from the exact text, original HTML, URL-list, and traversal bytes in that one
fixed browser evaluation. The runtime parses its root attributes and rejects a
wrong attempt, duplicate evidence marker, or missing embedded component. This
remains producer-declared evidence, not browser attestation or proof against
deliberate fabrication. Historical v1 evidence DOMs retain their separately
staged text, URL, and traversal compatibility path.
Run `bma-researcher materialize-browser-rendered-capture` once per capture-local
materialization attempt with the citation-free capture draft and sole current
evidence DOM owner-private file. Package only
the emitted `capture-browser-rendered.json`; package revalidates its hash-bound
private materialization inputs and rejects a caller-authored substitute. The
portable occurrence map binds Deep Research numbered marker-candidate spans 1
through 999 to retained source indexes or Pro line-bounded marker candidates to response-local
ChatGPT source anchors with matching `href`/`alt`, `_blank` target, and
`noopener` relation.
Missing indexes, nonportable attachment references, and visible `+N` members
without retained locators remain partial; the map proves neither entailment,
compound-member completeness, provider-UI completeness, nor an ambiguous
candidate's exact UI role or DOM-to-innerText position. A
pre-emission local validation failure may be corrected in capture-local staging
and rematerialized against the same completed response; never rerun after
successful emission. Do not use clipboard text, manually
rebuild report Markdown, hand-author citation rows, or claim a native export.

Current occurrence maps use
`bma_researcher_browser_rendered_citation_occurrence_map.v2` with
`unresolved_additional_compound_member_count_lower_bound`. Historical v1 maps
retain their former field name and rendered wording during exact readback.
