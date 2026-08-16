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
7. Require completed attachment UI with the exact visible filename. Fill the
   composer once with exactly `Use the attached provider-input.md as the
   complete request.` Require exact readback, no other composer text, no
   `[Truncated]`, and an enabled send control before preflight.

The chooser, attachment, and enabled Send prove browser control only. They do
not prove provider attention, extraction, semantic use, or a completed send.
Do not send a `transport-probe` fixture.
