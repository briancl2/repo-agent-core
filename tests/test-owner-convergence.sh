#!/usr/bin/env bash
# Focused cached-index, base-delta, and exact-consumer tests.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/repo-agent-core-owner-convergence.XXXXXX")"
trap 'rm -rf "$TMP_ROOT"' EXIT

REPO="$TMP_ROOT/repo"
INSTALLED="$TMP_ROOT/installed"
mkdir -p "$REPO/docs" "$REPO/compat" "$REPO/schemas" "$REPO/scripts" "$REPO/tests"
mkdir -p "$INSTALLED/private-name/skills/example"
mkdir -p "$INSTALLED/private-name/agents" "$INSTALLED/private-name/prompts"

git -C "$REPO" init -q
git -C "$REPO" config user.email "owner-convergence@example.invalid"
git -C "$REPO" config user.name "Owner Convergence Test"

printf '%s\n' '# Constitution' 'Exact fixture bytes.' > "$REPO/CONSTITUTION.md"
printf '%s\n' \
  '# Bootloader' \
  'Package owner route.' \
  'Active owner route.' \
  'Floor test route.' \
  'docs/live-capability-inventory.md' \
  'schemas/*.schema.json' \
  > "$REPO/AGENTS.md"
printf '%s\n' '# Package' 'AGENTS.md' > "$REPO/README.md"
printf '%s\n' 'ACTIVE_TOKEN' > "$REPO/active.txt"
printf '%s\n' 'compatibility bytes' > "$REPO/compat/keep.md"
printf '%s\n' 'retired compatibility bytes' > "$REPO/compat/retired.md"
printf '%s\n' '{"type":"object"}' > "$REPO/schemas/FIXTURE.schema.json"
printf '%s\n' 'rollback source a' > "$REPO/removed-a.txt"
printf '%s\n' 'rollback source b' > "$REPO/removed-b.txt"
printf '%s\n' 'retained base path' > "$REPO/unclassified.txt"
printf '%s\n' 'canonical floor validator bytes' > "$REPO/scripts/validate-floor-receipt.sh"
printf '%s\n' 'read-only fleet floor audit bytes' > "$REPO/scripts/fleet-floor-conformance-audit.sh"
printf '%s\n' \
  'scripts/validate-floor-receipt.sh' \
  'scripts/fleet-floor-conformance-audit.sh' \
  > "$REPO/tests/test-floor-receipt-conformance.sh"
printf '%s\n' '# Historical inventory' > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add .
git -C "$REPO" commit -qm "base"

BASE="$(git -C "$REPO" rev-parse HEAD)"
rm "$REPO/removed-a.txt" "$REPO/removed-b.txt" "$REPO/compat/retired.md"
printf '%s\n' \
  '# Owner package inventory' \
  '' \
  '## Active exports' \
  '' \
  '| Path | Class | Owner evidence | Auditor evidence | Advisor evidence | Optimizer evidence |' \
  '|---|---|---|---|---|---|' \
  '| `CONSTITUTION.md` | floor | `AGENTS.md::Package owner route.` | - | - | - |' \
  '| `AGENTS.md` | bootloader | `README.md::AGENTS.md` | - | - | - |' \
  '| `README.md` | entrypoint | `AGENTS.md::Package owner route.` | - | - | - |' \
  '| `docs/live-capability-inventory.md` | owner-manifest | `AGENTS.md::docs/live-capability-inventory.md` | - | - | - |' \
  '| `active.txt` | fixture export | `AGENTS.md::Active owner route.` | `evidence.txt::ACTIVE_TOKEN` | `evidence.txt::ACTIVE_TOKEN` | `evidence.txt::ACTIVE_TOKEN` |' \
  '| `schemas/FIXTURE.schema.json` | schema export | `AGENTS.md::schemas/*.schema.json` | - | - | - |' \
  '| `scripts/validate-floor-receipt.sh` | floor validator | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `evidence.txt::FLOOR_TOKEN` | `evidence.txt::FLOOR_TOKEN` | `scripts/validate-owner-convergence.py::scripts/validate-floor-receipt.sh` |' \
  '| `scripts/fleet-floor-conformance-audit.sh` | fleet audit | `tests/test-floor-receipt-conformance.sh::scripts/fleet-floor-conformance-audit.sh` | - | - | - |' \
  '| `tests/test-floor-receipt-conformance.sh` | floor tests | `AGENTS.md::Floor test route.` | - | - | - |' \
  '' \
  '## Compatibility-only retained paths' \
  '' \
  '| Pattern | Classification |' \
  '|---|---|' \
  '| `compat/*.md` | retained contract |' \
  '| `schemas/*.schema.json` | unchanged schema |' \
  '| `unclassified.txt` | classified retained fixture |' \
  '' \
  '## Removed-name successor rules' \
  '' \
  '| Removed pattern | Successor |' \
  '|---|---|' \
  '| `removed-*.txt` | `active.txt` |' \
  '' \
  '## Exact terminal retirements' \
  '' \
  '| Exact path | Disposition |' \
  '|---|---|' \
  '| `compat/retired.md` | `retired-without-successor` |' \
  > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add -A
cp "$REPO/docs/live-capability-inventory.md" "$TMP_ROOT/good-inventory.md"

printf '%s\n' 'name: private-name' > "$INSTALLED/private-name/skills/example/SKILL.md"
printf '%s\n' 'private agent' > "$INSTALLED/private-name/agents/private-name.agent.md"
printf '%s\n' 'private prompt' > "$INSTALLED/private-name/prompts/private-name.prompt.md"
printf '%s\n' 'private instructions' > "$INSTALLED/private-name/AGENTS.md"

make_consumer() {
  local label="$1"
  local consumer="$TMP_ROOT/$label"
  mkdir -p "$consumer"
  git -C "$consumer" init -q
  git -C "$consumer" config user.email "owner-convergence@example.invalid"
  git -C "$consumer" config user.name "Owner Convergence Test"
  printf '%s\n' 'ACTIVE_TOKEN' 'FLOOR_TOKEN' > "$consumer/evidence.txt"
  if [ "$label" = "optimizer" ]; then
    mkdir -p "$consumer/scripts"
    printf '%s\n' 'scripts/validate-floor-receipt.sh' \
      > "$consumer/scripts/validate-owner-convergence.py"
  fi
  if [ "$label" = "auditor" ]; then
    local newline_path
    newline_path="$consumer/"$'line\nbreak.txt'
    printf '%s\n' 'removed-a.txt' > "$newline_path"
  fi
  git -C "$consumer" add .
  git -C "$consumer" commit -qm "consumer fixture"
}

make_consumer auditor
make_consumer advisor
make_consumer optimizer
AUDITOR_REF="$(git -C "$TMP_ROOT/auditor" rev-parse HEAD)"
ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
OPTIMIZER_REF="$(git -C "$TMP_ROOT/optimizer" rev-parse HEAD)"

PASS=0
FAIL=0

pass() {
  PASS=$((PASS + 1))
  echo "  PASS: $1"
}

fail() {
  FAIL=$((FAIL + 1))
  echo "  FAIL: $1"
}

reporting_guidance() {
  awk '
    function emit(line) {
      output[++output_count] = line
    }

    function is_space(character) {
      return character ~ /^[[:space:]]$/
    }

    function is_tag_name_character(character) {
      return character ~ /^[A-Za-z0-9-]$/
    }

    function is_attribute_name_start(character) {
      return character ~ /^[A-Za-z_:]$/
    }

    function is_attribute_name_character(character) {
      return character ~ /^[A-Za-z0-9_.:-]$/
    }

    function valid_type_seven_open_tag(text, length_text, position, character, saw_space, quote, value_start, closed, separator_ready) {
      length_text = length(text)
      if (substr(text, 1, 1) != "<" ||
          substr(text, 2, 1) !~ /^[A-Za-z]$/) return 0

      position = 3
      while (position <= length_text &&
             is_tag_name_character(substr(text, position, 1))) position++

      while (position <= length_text) {
        saw_space = separator_ready
        separator_ready = 0
        while (position <= length_text &&
               is_space(substr(text, position, 1))) {
          position++
          saw_space = 1
        }

        if (substr(text, position, 1) == ">") {
          position++
          closed = 1
          break
        }
        if (substr(text, position, 2) == "/>") {
          position += 2
          closed = 1
          break
        }
        if (!saw_space ||
            !is_attribute_name_start(substr(text, position, 1))) return 0

        position++
        while (position <= length_text &&
               is_attribute_name_character(substr(text, position, 1))) position++
        saw_space = 0
        while (position <= length_text &&
               is_space(substr(text, position, 1))) {
          position++
          saw_space = 1
        }

        if (substr(text, position, 1) == "=") {
          position++
          while (position <= length_text &&
                 is_space(substr(text, position, 1))) position++
          character = substr(text, position, 1)
          if (character == "\"" || character == sprintf("%c", 39)) {
            quote = character
            position++
            while (position <= length_text &&
                   substr(text, position, 1) != quote) position++
            if (position > length_text) return 0
            position++
          } else {
            value_start = position
            while (position <= length_text) {
              character = substr(text, position, 1)
              if (is_space(character) || character == "\"" ||
                  character == sprintf("%c", 39) || character == "=" ||
                  character == "<" || character == ">" ||
                  character == "`") break
              position++
            }
            if (position == value_start) return 0
          }
        } else if (saw_space) {
          separator_ready = 1
        }
      }

      if (!closed) return 0
      while (position <= length_text &&
             is_space(substr(text, position, 1))) position++
      return position > length_text
    }

    function is_thematic_break(text, compact, marker, offset) {
      compact = text
      gsub(/[[:space:]]/, "", compact)
      if (length(compact) < 3) return 0
      marker = substr(compact, 1, 1)
      if (marker != "*" && marker != "-" && marker != "_") return 0
      for (offset = 2; offset <= length(compact); offset++) {
        if (substr(compact, offset, 1) != marker) return 0
      }
      return 1
    }

    function link_reference_title_status(text, opener, closer, position, character, remainder) {
      if (length(text) < 1) return 0
      opener = substr(text, 1, 1)
      if (opener == "\"") closer = "\""
      else if (opener == sprintf("%c", 39)) closer = sprintf("%c", 39)
      else if (opener == "(") closer = ")"
      else return 0

      position = 2
      while (position <= length(text)) {
        character = substr(text, position, 1)
        if (character == "\\") {
          position += 2
          continue
        }
        if (opener == "(" && character == "(") return 0
        if (character == closer) {
          remainder = substr(text, position + 1)
          return remainder ~ /^[[:space:]]*$/
        }
        position++
      }
      link_title_closer = closer
      link_title_opener = opener
      return 2
    }

    function link_reference_title_continuation_status(text, position, character, remainder) {
      position = 1
      while (position <= length(text)) {
        character = substr(text, position, 1)
        if (character == "\\") {
          position += 2
          continue
        }
        if (link_title_opener == "(" && character == "(") return 0
        if (character == link_title_closer) {
          remainder = substr(text, position + 1)
          return remainder ~ /^[[:space:]]*$/
        }
        position++
      }
      return 2
    }

    function link_reference_destination_status(text, position, character, destination_start, depth, had_separator, remainder) {
      position = 1
      while (position <= length(text) && is_space(substr(text, position, 1))) position++
      if (position > length(text)) return 0
      if (substr(text, position, 1) == "<") {
        position++
        while (position <= length(text)) {
          character = substr(text, position, 1)
          if (character == "\\") {
            if (position == length(text)) return 0
            position += 2
            continue
          }
          if (character == "<") return 0
          if (character == ">") break
          position++
        }
        if (position > length(text)) return 0
        position++
      } else {
        destination_start = position
        depth = 0
        while (position <= length(text) && !is_space(substr(text, position, 1))) {
          character = substr(text, position, 1)
          if (character == "\\") {
            if (position == length(text)) return 0
            position += 2
            continue
          }
          if (character == "<" || character ~ /^[[:cntrl:]]$/) return 0
          if (character == "(") depth++
          else if (character == ")") {
            if (depth == 0) return 0
            depth--
          }
          position++
        }
        if (position == destination_start || depth != 0) return 0
      }

      had_separator = 0
      while (position <= length(text) && is_space(substr(text, position, 1))) {
        position++
        had_separator = 1
      }
      if (position > length(text)) return 2
      if (!had_separator) return 0
      remainder = substr(text, position)
      title_status = link_reference_title_status(remainder)
      if (title_status == 1) return 1
      if (title_status == 2) return 4
      return 0
    }

    function consume_link_reference_label(text, position, character) {
      while (position <= length(text)) {
        character = substr(text, position, 1)
        if (character == "\\") {
          if (position == length(text)) return 0
          position += 2
          link_label_length++
          link_label_nonspace = 1
          continue
        }
        if (character == "[") return 0
        if (character == "]") {
          if (substr(text, position + 1, 1) != ":") return 0
          link_label_remainder = substr(text, position + 2)
          return 1
        }
        link_label_length++
        if (!is_space(character)) link_label_nonspace = 1
        if (link_label_length > 999) return 0
        position++
      }
      return 2
    }

    function link_reference_definition_status(text, label_status) {
      if (substr(text, 1, 1) != "[") return 0
      link_label_length = 0
      link_label_nonspace = 0
      link_label_remainder = ""
      label_status = consume_link_reference_label(text, 2)
      if (label_status == 2) return 5
      if (label_status != 1 || !link_label_nonspace) return 0

      if (link_label_remainder ~ /^[[:space:]]*$/) return 3
      return link_reference_destination_status(link_label_remainder)
    }

    function container_content_opens_paragraph(text, remainder, number_text) {
      if (text ~ /^[[:space:]]*$/ ||
          text ~ /^    / ||
          is_thematic_break(text) ||
          text ~ /^#{1,6}([[:space:]]|$)/ ||
          text ~ /^```/ || text ~ /^~~~/ ||
          html_block_type(text, 1) ||
          link_reference_definition_status(text)) return 0

      if (text ~ /^>[[:space:]]?/) {
        remainder = text
        sub(/^>[[:space:]]?/, "", remainder)
        return container_content_opens_paragraph(remainder)
      }
      if (text ~ /^[*+-]([[:space:]]|$)/) {
        remainder = text
        sub(/^[*+-][[:space:]]*/, "", remainder)
        return container_content_opens_paragraph(remainder)
      }
      if (match(text, /^[0-9]+[.)]([[:space:]]|$)/)) {
        number_text = substr(text, 1, RLENGTH)
        sub(/[.)][[:space:]]*$/, "", number_text)
        if (length(number_text) <= 9) {
          remainder = substr(text, RLENGTH + 1)
          return container_content_opens_paragraph(remainder)
        }
      }
      return 1
    }

    function starts_nonparagraph_block(text, paragraph_was_open, remainder, number_text) {
      if (is_thematic_break(text) ||
          text ~ /^#{1,6}([[:space:]]|$)/) return 1

      if (text ~ /^>[[:space:]]?/) {
        remainder = text
        sub(/^>[[:space:]]?/, "", remainder)
        return !container_content_opens_paragraph(remainder)
      }
      if (text ~ /^[*+-]([[:space:]]|$)/) {
        remainder = text
        sub(/^[*+-][[:space:]]*/, "", remainder)
        return !container_content_opens_paragraph(remainder)
      }

      if (match(text, /^[0-9]+[.)]([[:space:]]|$)/)) {
        number_text = substr(text, 1, RLENGTH)
        sub(/[.)][[:space:]]*$/, "", number_text)
        if (length(number_text) > 9) return 0
        if (paragraph_was_open && number_text != "1") return 0
        remainder = substr(text, RLENGTH + 1)
        return !container_content_opens_paragraph(remainder)
      }
      return 0
    }

    function interrupts_reference_candidate(text, indentation, number_text, html_type) {
      if (indentation > 3) return 0
      html_type = html_block_type(text, 0)
      if (text ~ /^#{1,6}([[:space:]]|$)/ ||
          text ~ /^>[[:space:]]?/ ||
          text ~ /^[*+-]([[:space:]]|$)/ ||
          is_thematic_break(text) ||
          text ~ /^```/ || text ~ /^~~~/ ||
          (html_type >= 1 && html_type <= 6)) return 1
      if (match(text, /^[0-9]+[.)]([[:space:]]|$)/)) {
        number_text = substr(text, 1, RLENGTH)
        sub(/[.)][[:space:]]*$/, "", number_text)
        return length(number_text) <= 9 && number_text == "1"
      }
      return 0
    }

    function marker_padding_columns(text, marker_width, indentation, position, column, character) {
      position = marker_width + 1
      column = indentation + marker_width
      while (position <= length(text)) {
        character = substr(text, position, 1)
        if (character == " ") column++
        else if (character == "\t") column += 4 - (column % 4)
        else break
        position++
      }
      return column - indentation - marker_width
    }

    function list_marker_content_indent(text, indentation, paragraph_was_open, marker, number_text, marker_width, padding, raw_padding, continues_list, whitespace_chars, remainder) {
      current_list_opens_paragraph = 0
      current_list_kind = ""
      if (is_thematic_break(text)) return 0
      if (text ~ /^[*+-]([[:space:]]|$)/) {
        if (length(text) == 1 && paragraph_was_open) return 0
        current_list_kind = "u" substr(text, 1, 1)
        padding = length(text) == 1 ? 1 : marker_padding_columns(text, 1, indentation)
        raw_padding = padding
        if (padding > 4) padding = 1
        if (length(text) > 1) {
          match(substr(text, 2), /^[[:space:]]+/)
          whitespace_chars = RLENGTH
          remainder = raw_padding > 4 ? substr(text, 3) : substr(text, 2 + whitespace_chars)
          current_list_opens_paragraph = container_content_opens_paragraph(remainder)
        }
        return indentation + 1 + padding
      }
      if (match(text, /^[0-9]+[.)]/)) {
        marker_width = RLENGTH
        number_text = substr(text, 1, marker_width - 1)
        current_list_kind = "o" substr(text, marker_width, 1)
        if (length(text) == marker_width) padding = 1
        else {
          if (substr(text, marker_width + 1) !~ /^[[:space:]]/) return 0
          padding = marker_padding_columns(text, marker_width, indentation)
        }
        raw_padding = padding
        if (padding > 4) padding = 1
        continues_list = list_depth && indentation == list_marker_indents[list_depth] &&
                         current_list_kind == list_marker_kinds[list_depth]
        if (length(number_text) <= 9 &&
            (!paragraph_was_open || number_text == "1" || continues_list)) {
          if (length(text) > marker_width) {
            match(substr(text, marker_width + 1), /^[[:space:]]+/)
            whitespace_chars = RLENGTH
            remainder = raw_padding > 4 ? substr(text, marker_width + 2) : substr(text, marker_width + 1 + whitespace_chars)
            current_list_opens_paragraph = container_content_opens_paragraph(remainder)
          }
          return indentation + marker_width + padding
        }
      }
      return 0
    }

    function underindented_nonlist_block(text, indentation, html_type) {
      if (indentation > 3) return 0
      html_type = html_block_type(text, 0)
      return text ~ /^#{1,6}([[:space:]]|$)/ ||
             text ~ /^>[[:space:]]?/ ||
             is_thematic_break(text) ||
             text ~ /^```/ || text ~ /^~~~/ ||
             (html_type >= 1 && html_type <= 6)
    }

    function html_block_type(text, allow_type_seven, lower) {
      lower = tolower(text)
      if (match(lower, /^<(pre|script|style|textarea)([[:space:]>]|$)/)) {
        match(substr(lower, 2), /^(pre|script|style|textarea)/)
        html_type_one_tag = substr(lower, 2, RLENGTH)
        return 1
      }
      if (text ~ /^<!--/) return 2
      if (text ~ /^<\?/) return 3
      if (text ~ /^<![A-Za-z]/) return 4
      if (text ~ /^<!\[CDATA\[/) return 5
      if (lower ~ /^<\/?(address|article|aside|base|basefont|blockquote|body|caption|center|col|colgroup|dd|details|dialog|dir|div|dl|dt|fieldset|figcaption|figure|footer|form|frame|frameset|h1|h2|h3|h4|h5|h6|head|header|hr|html|iframe|legend|li|link|main|menu|menuitem|nav|noframes|ol|optgroup|option|p|param|search|section|summary|table|tbody|td|tfoot|th|thead|title|tr|track|ul)([[:space:]>]|\/>|$)/) return 6
      if (allow_type_seven &&
          (text ~ /^<\/[A-Za-z][A-Za-z0-9-]*[[:space:]]*>[[:space:]]*$/ ||
           valid_type_seven_open_tag(text))) return 7
      return 0
    }

    function html_block_ended(type, text, lower) {
      lower = tolower(text)
      if (type == 1) {
        return lower ~ /<\/(pre|script|style|textarea)>/
      }
      if (type == 2) return text ~ /-->/
      if (type == 3) return text ~ /\?>/
      if (type == 4) return text ~ />/
      if (type == 5) return text ~ /\]\]>/
      return (type == 6 || type == 7) && text ~ /^[[:space:]]*$/
    }

    {
      content = $0
      match(content, /^ */)
      indentation = RLENGTH
      sub(/^ */, "", content)
      blank = ($0 ~ /^[[:space:]]*$/)
      was_blank = previous_blank
      previous_blank = blank
      paragraph_was_open = paragraph_open
      while (list_depth && indentation < list_content_indents[list_depth] &&
             underindented_nonlist_block(content, indentation)) {
        delete list_marker_indents[list_depth]
        delete list_content_indents[list_depth]
        delete list_item_paragraphs[list_depth]
        delete list_marker_kinds[list_depth]
        list_depth--
      }

      if (link_label_pending) {
        if (blank) {
          link_label_pending = 0
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
        if (interrupts_reference_candidate(content, indentation)) {
          link_label_pending = 0
          paragraph_open = 1
        } else {
        label_status = consume_link_reference_label(content, 1)
        if (label_status == 2) {
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
        link_label_pending = 0
        if (label_status == 1 && link_label_nonspace) {
          if (link_label_remainder ~ /^[[:space:]]*$/) reference_status = 3
          else reference_status = link_reference_destination_status(link_label_remainder)
          if (reference_status) {
            if (reference_status == 2) link_reference_pending = 1
            else if (reference_status == 3) link_destination_pending = 1
            else if (reference_status == 4) link_title_pending = 1
            paragraph_open = 0
            if (in_reporting) emit($0)
            next
          }
        }
        paragraph_open = 1
        }
      }

      if (link_title_pending) {
        if (blank) {
          link_title_pending = 0
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
        if (interrupts_reference_candidate(content, indentation)) {
          link_title_pending = 0
          paragraph_open = 1
        } else {
        title_status = link_reference_title_continuation_status(content)
        if (title_status == 1 || title_status == 2) {
          link_title_pending = (title_status == 2)
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
        link_title_pending = 0
        paragraph_open = 1
        }
      }

      if (link_destination_pending) {
        link_destination_pending = 0
        destination_status = link_reference_destination_status(content)
        if (indentation <= 3 && destination_status) {
          if (destination_status == 2) link_reference_pending = 1
          else if (destination_status == 4) link_title_pending = 1
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
        paragraph_open = 1
      }

      if (link_reference_pending) {
        link_reference_pending = 0
        title_status = link_reference_title_status(content)
        if (indentation <= 3 && (title_status == 1 || title_status == 2)) {
          link_title_pending = (title_status == 2)
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
      }

      if (in_fence && fence_container_indent && !blank &&
          indentation < fence_container_indent) {
        in_fence = 0
        fence_container_indent = 0
        paragraph_open = 0
      }

      if (in_html && html_container_indent && !blank &&
          indentation < html_container_indent) {
        in_html = 0
        html_container_indent = 0
        paragraph_open = 0
      }

      if (in_html) {
        if (in_reporting) emit($0)
        if (html_block_ended(in_html, $0)) {
          in_html = 0
          html_container_indent = 0
          paragraph_open = 0
        }
        next
      }

      if (in_fence) {
        closing = content
        sub(/[[:space:]]*$/, "", closing)
        if (indentation <= 3 &&
            ((fence_marker == "`" && closing ~ /^`+$/) ||
             (fence_marker == "~" && closing ~ /^~+$/))) {
          if (length(closing) >= fence_length) {
            in_fence = 0
            fence_container_indent = 0
            paragraph_open = 0
          }
        }
        if (in_reporting) emit($0)
        next
      }

      if (indentation <= 3 && content ~ /^```/) {
        match(content, /^`+/)
        fence_info = substr(content, RLENGTH + 1)
        if (fence_info !~ /`/) {
          in_fence = 1
          fence_marker = "`"
          fence_length = RLENGTH
          fence_container_indent = list_depth ? list_content_indents[list_depth] : 0
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
      }
      if (indentation <= 3 && content ~ /^~~~/) {
        match(content, /^~+/)
        in_fence = 1
        fence_marker = "~"
        fence_length = RLENGTH
        fence_container_indent = list_depth ? list_content_indents[list_depth] : 0
        paragraph_open = 0
        if (in_reporting) emit($0)
        next
      }

      html_type = 0
      if (indentation <= 3) {
        html_type = html_block_type(content, !paragraph_open)
      }
      if (html_type) {
        in_html = html_type
        html_container_indent = list_depth ? list_content_indents[list_depth] : 0
        paragraph_open = 0
        if (in_reporting) emit($0)
        if (html_block_ended(in_html, $0)) {
          in_html = 0
          html_container_indent = 0
        }
        next
      }

      current_list_indent = list_marker_content_indent(content, indentation, paragraph_open)
      if (current_list_indent) {
        while (list_depth && indentation < list_marker_indents[list_depth]) {
          delete list_marker_indents[list_depth]
          delete list_content_indents[list_depth]
          delete list_item_paragraphs[list_depth]
          delete list_marker_kinds[list_depth]
          list_depth--
        }
        if (list_depth && indentation == list_marker_indents[list_depth]) {
          list_content_indents[list_depth] = current_list_indent
          list_item_paragraphs[list_depth] = current_list_opens_paragraph
          list_marker_kinds[list_depth] = current_list_kind
        } else if (!list_depth || indentation >= list_content_indents[list_depth]) {
          list_depth++
          list_marker_indents[list_depth] = indentation
          list_content_indents[list_depth] = current_list_indent
          list_item_paragraphs[list_depth] = current_list_opens_paragraph
          list_marker_kinds[list_depth] = current_list_kind
        }
      } else if (!blank) {
        while (list_depth && indentation < list_content_indents[list_depth] &&
               (was_blank || !list_item_paragraphs[list_depth])) {
          delete list_marker_indents[list_depth]
          delete list_content_indents[list_depth]
          delete list_item_paragraphs[list_depth]
          delete list_marker_kinds[list_depth]
          list_depth--
        }
      }

      if (paragraph_open && indentation <= 3 &&
          content ~ /^(=+|-+)[[:space:]]*$/) {
        if (!setext_candidate_in_container) {
          if (setext_candidate_output_start) {
            for (candidate_output_index = setext_candidate_output_start;
                 candidate_output_index <= setext_candidate_output_end;
                 candidate_output_index++) {
              delete output[candidate_output_index]
            }
          }
          setext_candidate_output_start = 0
          setext_candidate_output_end = 0
          setext_heading = setext_candidate
          gsub(/[[:space:]]+/, " ", setext_heading)
          sub(/^[[:space:]]*/, "", setext_heading)
          sub(/[[:space:]]*$/, "", setext_heading)
          if (content ~ /^-+/) {
            in_reporting = (setext_heading == "Reporting and continuation")
          } else {
            in_reporting = 0
          }
        }
        paragraph_open = 0
        setext_candidate = ""
        setext_candidate_in_container = 0
        setext_candidate_output_start = 0
        setext_candidate_output_end = 0
        next
      }

      if (indentation <= 3 && content ~ /^#([[:space:]]|$)/) {
        while (list_depth && indentation < list_content_indents[list_depth]) {
          delete list_marker_indents[list_depth]
          delete list_content_indents[list_depth]
          delete list_item_paragraphs[list_depth]
          delete list_marker_kinds[list_depth]
          list_depth--
        }
        if (list_depth && indentation >= list_content_indents[list_depth]) {
          list_item_paragraphs[list_depth] = 0
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
        in_reporting = 0
        paragraph_open = 0
        setext_candidate = ""
        setext_candidate_in_container = 0
        setext_candidate_output_start = 0
        setext_candidate_output_end = 0
        next
      }

      if (indentation <= 3 && content ~ /^##([[:space:]]|$)/) {
        while (list_depth && indentation < list_content_indents[list_depth]) {
          delete list_marker_indents[list_depth]
          delete list_content_indents[list_depth]
          delete list_item_paragraphs[list_depth]
          delete list_marker_kinds[list_depth]
          list_depth--
        }
        if (list_depth && indentation >= list_content_indents[list_depth]) {
          list_item_paragraphs[list_depth] = 0
          paragraph_open = 0
          if (in_reporting) emit($0)
          next
        }
        heading = content
        sub(/^##[[:space:]]*/, "", heading)
        sub(/[[:space:]]+#+[[:space:]]*$/, "", heading)
        sub(/[[:space:]]*$/, "", heading)
        in_reporting = (heading == "Reporting and continuation")
        paragraph_open = 0
        setext_candidate = ""
        setext_candidate_in_container = 0
        setext_candidate_output_start = 0
        setext_candidate_output_end = 0
        next
      }
      reference_status = 0
      if (!paragraph_open && indentation <= 3) {
        reference_status = link_reference_definition_status(content)
      }
      if (blank ||
          reference_status ||
          (indentation <= 3 && starts_nonparagraph_block(content, paragraph_open)) ||
          (paragraph_open && indentation <= 3 &&
           content ~ /^(=+|-+)[[:space:]]*$/)) {
        if (reference_status == 2) link_reference_pending = 1
        else if (reference_status == 3) link_destination_pending = 1
        else if (reference_status == 4) link_title_pending = 1
        else if (reference_status == 5) link_label_pending = 1
        paragraph_open = 0
      } else if (indentation <= 3 || paragraph_open) {
        paragraph_open = 1
      }
      if (paragraph_open && !blank) {
        container_paragraph_starts = ((current_list_indent && current_list_opens_paragraph) || content ~ /^>[[:space:]]?/)
        if (paragraph_was_open && setext_candidate != "" &&
            !container_paragraph_starts) {
          setext_candidate = setext_candidate " " content
        } else {
          setext_candidate = content
          setext_candidate_in_container = (list_depth > 0 || content ~ /^>[[:space:]]?/)
          setext_candidate_output_start = 0
          setext_candidate_output_end = 0
        }
      } else if (blank) {
        setext_candidate = ""
        setext_candidate_in_container = 0
        setext_candidate_output_start = 0
        setext_candidate_output_end = 0
      }
      if (in_reporting) {
        emit($0)
        if (paragraph_open && !blank) {
          if (!setext_candidate_output_start) {
            setext_candidate_output_start = output_count
          }
          setext_candidate_output_end = output_count
        }
      }
    }
    END {
      for (output_index = 1; output_index <= output_count; output_index++) {
        if (output_index in output) print output[output_index]
      }
    }
  '
}

legacy_reporting_default_present() {
  local guidance
  guidance="$(reporting_guidance)"
  grep -Fq \
    -e 'Goal/Goal-null' \
    -e '/tmp' \
    -e 'batch count' \
    -e 'progress ledger' \
    -e 'heartbeat' \
    -e 'Issue-164 carrier' \
    <<< "$guidance"
}

CACHED_AGENTS="$(git -C "$ROOT" show :AGENTS.md)"
REPORTING_GUIDANCE="$(printf '%s\n' "$CACHED_AGENTS" | reporting_guidance)"

if grep -Fq '| `scripts/validate-floor-receipt.sh` | canonical portable floor validator | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `scripts/validate-owner-convergence.py::scripts/validate-floor-receipt.sh` |' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md); then
  pass "floor validator inventory preserves unrelated evidence and names Optimizer owner validation"
else
  fail "floor validator inventory preserves unrelated evidence and names Optimizer owner validation"
fi

if grep -Fq 'Material progress uses' <<< "$REPORTING_GUIDANCE" \
  && grep -Fq '`Delta / Next`' <<< "$REPORTING_GUIDANCE" \
  && grep -Fq '`Outcome / Residual / Next`' <<< "$REPORTING_GUIDANCE" \
  && grep -Fq '`Zoom-out`' <<< "$REPORTING_GUIDANCE"; then
  pass "active guidance carries compact proportional reporting forms"
else
  fail "active guidance carries compact proportional reporting forms"
fi

if grep -Fq 'reload the governing parent or owner outcome' <<< "$REPORTING_GUIDANCE" \
  && grep -Fq 'select the largest unclosed' <<< "$REPORTING_GUIDANCE" \
  && grep -Fq 'Do not default to the last local' <<< "$REPORTING_GUIDANCE"; then
  pass "sparse continuation reloads the governing outcome"
else
  fail "sparse continuation reloads the governing outcome"
fi

if printf '%s\n' "$CACHED_AGENTS" | legacy_reporting_default_present; then
  fail "legacy compatibility fields are absent from active reporting guidance"
else
  pass "legacy compatibility fields are absent from active reporting guidance"
fi

if printf '%s\n' \
  '## Package boundary' \
  'Test fixtures may use /tmp scratch paths when their cleanup is bounded.' \
  '## Reporting and continuation' \
  'Material progress uses Delta / Next.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  fail "legacy reporting terms remain allowed outside reporting guidance"
else
  pass "legacy reporting terms remain allowed outside reporting guidance"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  'Material progress uses Delta / Next.' \
  '## Native commands' \
  'Run make test.' \
  '## Reporting and continuation' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "legacy reporting defaults remain rejected across reporting guidance sections"
else
  fail "legacy reporting defaults remain rejected across reporting guidance sections"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '```text' \
  '## Example output' \
  '```' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "fenced headings do not truncate active reporting guidance"
else
  fail "fenced headings do not truncate active reporting guidance"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '    ```' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "indented code does not hide real reporting section boundaries"
else
  pass "indented code does not hide real reporting section boundaries"
fi

if printf '%s\n' \
  '   ## Reporting and continuation' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "valid indented reporting headings remain covered"
else
  fail "valid indented reporting headings remain covered"
fi

if printf '%s\n' \
  '## Package boundary' \
  '```text```' \
  '## Reporting and continuation' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "invalid backtick info strings do not hide reporting guidance"
else
  fail "invalid backtick info strings do not hide reporting guidance"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '<!--' \
  '## Native commands' \
  '-->' \
  '<script>' \
  '## Native commands' \
  '</scripture>' \
  '## Native commands' \
  '</script >' \
  '## Native commands' \
  '</script>' \
  '<?instruction' \
  '## Native commands' \
  '?>' \
  '<!DECLARATION' \
  '## Native commands' \
  '>' \
  '<![CDATA[' \
  '## Native commands' \
  ']]>' \
  '<div>' \
  '## Native commands' \
  '' \
  '[ref]:' \
  '  /target' \
  '  "title"' \
  '> <div>' \
  '<custom-tag>' \
  '## Native commands' \
  '' \
  '<custom-tag>' \
  '## Native commands' \
  '' \
  '---' \
  '<custom-tag disabled title="a>b">' \
  '## Native commands' \
  '' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "HTML blocks do not truncate active reporting guidance"
else
  fail "HTML blocks do not truncate active reporting guidance"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '<custom-tag =>' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "malformed HTML tags do not hide real reporting section boundaries"
else
  pass "malformed HTML tags do not hide real reporting section boundaries"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '<script>' \
  '## Native commands' \
  '</style>' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "any exact type-1 end tag closes the HTML block"
else
  pass "any exact type-1 end tag closes the HTML block"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '<!lowercase' \
  '## Native commands' \
  '>' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "type-4 declarations accept every ASCII letter"
else
  fail "type-4 declarations accept every ASCII letter"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  'A paragraph stays open.' \
  '[ref]: /target' \
  '<custom-tag>' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "paragraph continuations do not turn type-7 tags into HTML blocks"
else
  pass "paragraph continuations do not turn type-7 tags into HTML blocks"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '[ref]: /target' \
  '  "a"b"' \
  '<custom-tag>' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "invalid link titles do not hide real reporting section boundaries"
else
  pass "invalid link titles do not hide real reporting section boundaries"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '[ref]junk]: /target' \
  '<custom-tag>' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "the first unescaped closing bracket terminates a link label"
else
  pass "the first unescaped closing bracket terminates a link label"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '[' \
  'label' \
  ']: /target '"'" \
  'title' \
  "'" \
  '<custom-tag>' \
  '## Native commands' \
  '' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "multiline link labels and titles do not hide reporting guidance"
else
  fail "multiline link labels and titles do not hide reporting guidance"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '[   ]: /target' \
  '<custom-tag>' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "whitespace-only link labels do not hide real reporting boundaries"
else
  pass "whitespace-only link labels do not hide real reporting boundaries"
fi

if printf '%s\n' \
  '[' \
  '## Reporting and continuation' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "ATX headings interrupt unterminated link labels"
else
  fail "ATX headings interrupt unterminated link labels"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '[ref]: /target "unterminated' \
  '' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "blank lines terminate unterminated link titles"
else
  pass "blank lines terminate unterminated link titles"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '1234567890. ordinary text' \
  '<custom-tag>' \
  '## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "ten-digit paragraph prefixes are not Markdown list markers"
else
  pass "ten-digit paragraph prefixes are not Markdown list markers"
fi

if printf '%s\n' \
  '> note' \
  '<custom-tag>' \
  '## Reporting and continuation' \
  '' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "container paragraphs do not hide real reporting section boundaries"
else
  fail "container paragraphs do not hide real reporting section boundaries"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '- Outer example:' \
  '  - Nested example' \
  '  ## Native commands' \
  '-' \
  '  ## Native commands' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "list-nested headings do not truncate reporting guidance"
else
  fail "list-nested headings do not truncate reporting guidance"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  'A paragraph stays open.' \
  '2. ordinary text' \
  '  ## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "noninterrupting ordered prefixes do not create list containers"
else
  pass "noninterrupting ordered prefixes do not create list containers"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '10. First item' \
  '2. Second item' \
  '   ## Native commands' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "ordered sibling marker-width changes preserve list nesting"
else
  fail "ordered sibling marker-width changes preserve list nesting"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '-     Unordered item' \
  '  ## Native commands' \
  '1.     Ordered item' \
  '   ## Native commands' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "excess list padding counts as one content space"
else
  fail "excess list padding counts as one content space"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  $'-\tItem' \
  '  ## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "tab-expanded list padding preserves document-level headings"
else
  pass "tab-expanded list padding preserves document-level headings"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '```text' \
  '- code' \
  '```' \
  '  ## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "opaque blocks do not mutate list-container state"
else
  pass "opaque blocks do not mutate list-container state"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '- ## List heading' \
  'Outside paragraph.' \
  '  ## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "nonparagraph list items do not retain stale container state"
else
  pass "nonparagraph list items do not retain stale container state"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  'Paragraph heading' \
  '-' \
  '  ## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "empty markers do not interrupt open paragraphs"
else
  pass "empty markers do not interrupt open paragraphs"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '- Item' \
  '```text' \
  'code' \
  '```' \
  '  ## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "under-indented opaque blocks terminate list containers"
else
  pass "under-indented opaque blocks terminate list containers"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '- Item' \
  '2. ordinary text' \
  '  ## Native commands' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "incompatible unordered-to-ordered markers remain lazy continuation"
else
  fail "incompatible unordered-to-ordered markers remain lazy continuation"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '1. Item' \
  '2) ordinary text' \
  '   ## Native commands' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "ordered delimiter changes remain lazy continuation"
else
  fail "ordered delimiter changes remain lazy continuation"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '-     code' \
  'Outside paragraph.' \
  '  ## Native commands' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "excess-padding code does not retain lazy list paragraph state"
else
  pass "excess-padding code does not retain lazy list paragraph state"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  'Compatibility /tmp paths' \
  '---------------' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "Setext level-two siblings terminate reporting guidance"
else
  pass "Setext level-two siblings terminate reporting guidance"
fi

if printf '%s\n' \
  'Reporting and continuation' \
  '--------------------------' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "Setext reporting headings enter reporting guidance"
else
  fail "Setext reporting headings enter reporting guidance"
fi

if printf '%s\n' \
  'Reporting and' \
  'continuation' \
  '------------' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "soft-wrapped Setext reporting headings enter reporting guidance"
else
  fail "soft-wrapped Setext reporting headings enter reporting guidance"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  'Compatibility /tmp' \
  'paths' \
  '-----' \
  'Native fixtures remain owner-local.' \
  | legacy_reporting_default_present; then
  fail "soft-wrapped Setext sibling headings are fully excluded"
else
  pass "soft-wrapped Setext sibling headings are fully excluded"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '> Quoted context.' \
  '---' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "block-quote paragraphs do not turn thematic breaks into section boundaries"
else
  fail "block-quote paragraphs do not turn thematic breaks into section boundaries"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  'Ordinary paragraph.' \
  '> Quoted context.' \
  '---' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "block quotes reset interrupted Setext candidates"
else
  fail "block quotes reset interrupted Setext candidates"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  'Ordinary paragraph.' \
  '- List context.' \
  '---' \
  'Publish a heartbeat after every step.' \
  '## Native commands' \
  | legacy_reporting_default_present; then
  pass "list items reset interrupted Setext candidates"
else
  fail "list items reset interrupted Setext candidates"
fi

if printf '%s\n' \
  '- List context.' \
  '  ```' \
  '  quoted code' \
  '## Reporting and continuation' \
  'Publish a heartbeat after every step.' \
  | legacy_reporting_default_present; then
  pass "list-container exits terminate nested fenced blocks"
else
  fail "list-container exits terminate nested fenced blocks"
fi

if printf '%s\n' \
  '- List context.' \
  '  <script>' \
  '  quoted code' \
  '## Reporting and continuation' \
  'Publish a heartbeat after every step.' \
  | legacy_reporting_default_present; then
  pass "list-container exits terminate nested HTML blocks"
else
  fail "list-container exits terminate nested HTML blocks"
fi

if printf '%s\n' \
  '> Reporting and continuation' \
  '---' \
  'Publish a heartbeat after every step.' \
  | legacy_reporting_default_present; then
  fail "block-quote paragraphs do not create reporting sections"
else
  pass "block-quote paragraphs do not create reporting sections"
fi

if printf '%s\n' \
  '## Reporting and continuation' \
  '# Compatibility material' \
  'Test fixtures may use /tmp scratch paths.' \
  | legacy_reporting_default_present; then
  fail "ATX level-one siblings terminate reporting guidance"
else
  pass "ATX level-one siblings terminate reporting guidance"
fi

if grep -Fq '`docs/codex-native-runtime-readiness-contract.md`' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md) \
  && grep -Fq '`templates/codex-native-runtime-readiness.md`' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md) \
  && grep -Fq '`docs/goal-episode-evaluation-contract.md`' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md) \
  && grep -Fq '`templates/goal-episode-evaluation.md`' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md) \
  && grep -Fq 'are not ordinary reporting or execution defaults.' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md); then
  pass "caller-bound Goal/runtime surfaces stay explicitly compatibility only"
else
  fail "caller-bound Goal/runtime surfaces stay explicitly compatibility only"
fi

expect_pass() {
  local label="$1"
  shift
  if "$@" > "$TMP_ROOT/stdout" 2> "$TMP_ROOT/stderr"; then
    pass "$label"
  else
    fail "$label"
    sed -n '1,20p' "$TMP_ROOT/stderr"
  fi
}

expect_fail() {
  local label="$1"
  shift
  if "$@" > "$TMP_ROOT/stdout" 2> "$TMP_ROOT/stderr"; then
    fail "$label"
  else
    pass "$label"
  fi
}

VALIDATE=(
  python3 "$ROOT/scripts/validate_owner_convergence.py"
  --repo "$REPO"
  --base-ref "$BASE"
  --installed-root "$INSTALLED"
  --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF"
  --consumer "advisor=$TMP_ROOT/advisor@$ADVISOR_REF"
  --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
)

expect_pass "cached index, declared compatibility retirement, schema identity, and three consumers pass" "${VALIDATE[@]}"
cp "$TMP_ROOT/stdout" "$TMP_ROOT/positive.json"
for expected in \
  '"consumer_count": 3' \
  '"caller_checks": 6' \
  '"deleted_paths": 3' \
  '"orphan_active_exports": 0' \
  '"removed_reference_files": 1' \
  '"terminal_retirements": 1' \
  '"unchanged_floor_export_blobs": 1' \
  '"unchanged_schema_blobs": 1' \
  '"unclassified_index_paths": 0'
do
  if grep -Fq "$expected" "$TMP_ROOT/positive.json"; then
    pass "positive receipt contains $expected"
  else
    fail "positive receipt contains $expected"
  fi
done
echo "  synthetic receipt: $(cat "$TMP_ROOT/positive.json")"

if grep -Fq "private-name" "$TMP_ROOT/positive.json" "$TMP_ROOT/stderr"; then
  fail "installed discovery exposes no private names"
else
  pass "installed discovery exposes no private names"
fi

printf '%s\n' 'compat/retired.md is retained historical evidence' \
  > "$TMP_ROOT/advisor/history.md"
git -C "$TMP_ROOT/advisor" add history.md
git -C "$TMP_ROOT/advisor" commit -qm "retain historical terminal retirement evidence"
HISTORICAL_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "unclassified historical terminal mention remains fail closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$HISTORICAL_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
expect_pass \
  "explicit historical-only terminal retirement evidence remains allowed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$HISTORICAL_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF" \
    --historical-consumer-path "advisor=history.md"
git -C "$TMP_ROOT/advisor" rm -q history.md
git -C "$TMP_ROOT/advisor" commit -qm "remove historical fixture"

printf '%s\n' 'compat/retired.md' >> "$TMP_ROOT/advisor/evidence.txt"
git -C "$TMP_ROOT/advisor" add evidence.txt
git -C "$TMP_ROOT/advisor" commit -qm "retain terminal retirement reference"
TERMINAL_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement with a live consumer reference fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains referenced by advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "terminal-retirement rejection names the exact consumer ref"
else
  fail "terminal-retirement rejection names the exact consumer ref"
fi
expect_fail \
  "active caller evidence cannot be exempted as historical" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF" \
    --historical-consumer-path "advisor=evidence.txt"
if grep -Fq \
  'declared historical consumer path is active caller evidence in advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "active caller historical-exemption rejection names the exact consumer ref"
else
  fail "active caller historical-exemption rejection names the exact consumer ref"
fi
git -C "$TMP_ROOT/advisor" replace "$TERMINAL_ADVISOR_REF" "$ADVISOR_REF"
expect_fail \
  "replacement refs cannot mask a live terminal-retirement reference" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
git -C "$TMP_ROOT/advisor" replace -d "$TERMINAL_ADVISOR_REF" >/dev/null

git -C "$TMP_ROOT/advisor" restore --source="$ADVISOR_REF" -- evidence.txt
mkdir -p "$TMP_ROOT/advisor/compat"
printf '%s\n' 'retired contract bytes without a self-reference' \
  > "$TMP_ROOT/advisor/compat/retired.md"
git -C "$TMP_ROOT/advisor" add evidence.txt compat/retired.md
git -C "$TMP_ROOT/advisor" commit -qm "retain terminal retirement path"
TERMINAL_PATH_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement still vendored by a consumer fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_PATH_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains present in advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "terminal-retirement path rejection names the exact consumer ref"
else
  fail "terminal-retirement path rejection names the exact consumer ref"
fi

git -C "$TMP_ROOT/advisor" rm -q compat/retired.md
git -C "$TMP_ROOT/advisor" update-index --add --cacheinfo \
  160000 "$ADVISOR_REF" compat/retired.md
git -C "$TMP_ROOT/advisor" commit -qm "retain terminal retirement gitlink"
TERMINAL_GITLINK_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement retained as a consumer gitlink fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_GITLINK_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains present in advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "terminal-retirement gitlink rejection names the exact consumer ref"
else
  fail "terminal-retirement gitlink rejection names the exact consumer ref"
fi

git -C "$TMP_ROOT/advisor" rm -q compat/retired.md
mkdir -p "$TMP_ROOT/advisor/compat/retired.md"
printf '%s\n' 'retired path retained as a tree' \
  > "$TMP_ROOT/advisor/compat/retired.md/child.txt"
git -C "$TMP_ROOT/advisor" add compat/retired.md/child.txt
git -C "$TMP_ROOT/advisor" commit -qm "retain terminal retirement tree"
TERMINAL_TREE_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement retained as a consumer tree fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_TREE_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains present in advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "terminal-retirement tree rejection names the exact consumer ref"
else
  fail "terminal-retirement tree rejection names the exact consumer ref"
fi

git -C "$TMP_ROOT/advisor" rm -qr compat/retired.md
printf '\0%s\0' 'compat/retired.md' > "$TMP_ROOT/advisor/binary.manifest"
git -C "$TMP_ROOT/advisor" add binary.manifest
git -C "$TMP_ROOT/advisor" commit -qm "retain binary terminal retirement reference"
TERMINAL_BINARY_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement retained in a binary consumer blob fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_BINARY_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains referenced by advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "binary terminal-retirement rejection names the exact consumer ref"
else
  fail "binary terminal-retirement rejection names the exact consumer ref"
fi

sed 's#`compat/retired.md` | `retired-without-successor`#`compat/*.md` | `retired-without-successor`#' \
  "$TMP_ROOT/good-inventory.md" > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md
expect_fail "wildcard terminal retirement fails closed" "${VALIDATE[@]}"
cp "$TMP_ROOT/good-inventory.md" "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md

printf '%s\n' '# Bootloader' 'Issue #164 is active.' > "$REPO/AGENTS.md"
expect_pass "unstaged bad prose cannot override the clean cached index" "${VALIDATE[@]}"

git -C "$REPO" add AGENTS.md
expect_fail "staged retired authority fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree AGENTS.md

printf '\377\n' > "$REPO/README.md"
git -C "$REPO" add README.md
expect_fail "staged non-UTF-8 active prose fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree README.md

sed 's/evidence.txt::ACTIVE_TOKEN/evidence.txt::MISSING_TOKEN/' \
  "$TMP_ROOT/good-inventory.md" > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md
expect_fail "false per-export consumer caller evidence fails closed" "${VALIDATE[@]}"
cp "$TMP_ROOT/good-inventory.md" "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md

git -C "$REPO" rm -q active.txt
expect_fail "missing active export fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree active.txt

git -C "$REPO" rm -q compat/keep.md
expect_fail "one deleted retained compatibility contract fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree compat/keep.md

printf '%s\n' '{"type":"string"}' > "$REPO/schemas/FIXTURE.schema.json"
git -C "$REPO" add schemas/FIXTURE.schema.json
expect_fail "changed exported schema bytes fail closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree schemas/FIXTURE.schema.json

git -C "$REPO" rm -q scripts/validate-floor-receipt.sh
expect_fail "deleted canonical floor validator fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree scripts/validate-floor-receipt.sh

printf '%s\n' 'drifted floor validator bytes' > "$REPO/scripts/validate-floor-receipt.sh"
git -C "$REPO" add scripts/validate-floor-receipt.sh
expect_fail "drifted canonical floor validator fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree scripts/validate-floor-receipt.sh

git -C "$REPO" rm -q scripts/fleet-floor-conformance-audit.sh
expect_fail "deleted fleet floor audit fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree scripts/fleet-floor-conformance-audit.sh

printf '%s\n' 'drifted fleet floor audit bytes' > "$REPO/scripts/fleet-floor-conformance-audit.sh"
git -C "$REPO" add scripts/fleet-floor-conformance-audit.sh
expect_pass "owner-local fleet floor audit may evolve under focused coverage" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree scripts/fleet-floor-conformance-audit.sh

printf '%s\n' 'new unclassified path' > "$REPO/new-unclassified.txt"
git -C "$REPO" add new-unclassified.txt
expect_fail "new unclassified tracked path fails closed" "${VALIDATE[@]}"
git -C "$REPO" rm -q -f new-unclassified.txt

git -C "$REPO" restore --source="$BASE" --staged --worktree removed-a.txt
expect_fail "partially retained removed-name family fails closed" "${VALIDATE[@]}"
git -C "$REPO" rm -q removed-a.txt

git -C "$REPO" rm -q unclassified.txt
expect_fail "undeclared base-to-index deletion fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree unclassified.txt

git -C "$REPO" commit -qm "converged package"
cp "$ROOT/scripts/validate_owner_convergence.py" \
  "$REPO/scripts/validate_owner_convergence.py"
MAKE_VALIDATE=(
  env -u OWNER_CONVERGENCE_BASE_REF
  make --no-print-directory -s
  -C "$REPO"
  -f "$ROOT/Makefile"
  validate-owner-convergence
)
expect_pass "clean committed index defaults to HEAD^" "${MAKE_VALIDATE[@]}"
if grep -Fq '"deleted_paths": 3' "$TMP_ROOT/stdout"; then
  pass "clean committed index validates the latest commit delta"
else
  fail "clean committed index validates the latest commit delta"
fi

printf '%s\n' 'head-only compatibility bytes' > "$REPO/compat/head-only.md"
git -C "$REPO" add compat/head-only.md
git -C "$REPO" commit -qm "add compatibility path"
git -C "$REPO" rm -q compat/head-only.md
expect_fail \
  "staged deletion of HEAD-only compatibility path defaults to HEAD" \
  "${MAKE_VALIDATE[@]}"
if grep -Fq \
  "deleted path must match exactly one removed-name rule: compat/head-only.md" \
  "$TMP_ROOT/stderr"
then
  pass "staged deletion is evaluated against HEAD"
else
  fail "staged deletion is evaluated against HEAD"
fi

echo ""
echo "=== test-owner-convergence.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
