# AGENTS.md - vim-log-highlighting Development Guide

**Target Audience**: AI coding assistants (Claude, GPT, Cursor, Copilot)
**Project**: Vim syntax highlighting plugin for log files
**Maintainer**: MTDL9 <https://github.com/MTDL9/vim-log-highlighting>

---

## Project Structure

```
vim-log-highlighting/
├── syntax/
│   └── log.vim           # Main syntax file (227 lines) - All IP patterns (IPv4 + IPv6 + CIDR)
├── ftdetect/
│   └── log.vim           # Filetype detection (*.log, *_log)
├── doc/
│   └── screenshot.jpg    # Documentation screenshot
└── README.md             # User documentation
```

---

## Design Principles

1. **Single File**: All IP patterns (IPv4 + pure IPv6) inlined in `log.vim`
2. **RFC 5952 Compliant**: Pure IPv6 follows RFC 5952 (compression, full 8 segments, :: in any position)
3. **No IPv4-mapped**: `::ffff:192.168.1.1` formats are NOT highlighted (performance decision)
4. **Invalid IPv6 Filtering**: Strict boundary detection + prefix protection
   - `gggg::1` not highlighted (:: requires whitespace or bracket prefix)
   - All patterns ending with hex segments include `\(\.\d\)\@!` negative lookahead
5. **Performance First**: 42 simple patterns to avoid Vim NFA engine timeout (E872 error)
6. **CIDR Prefix Support**: `2001:db8::1/64` formats are highlighted
   - All 42 IPv6 patterns end with `\(\/\d\{1,3}\)\?` optional CIDR match
   - End boundary upgraded to `[^:/0-9a-fA-F]` (excludes `/` to prevent double consumption)
7. **Syntax Sync**: `syn sync minlines=500` balances scrolling accuracy and performance

---

## Code Style Guide

### Vim Script Conventions

```vim
" Correct pattern definition
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}\(\.\d\)\@!\([^:0-9a-fA-F]\|$\)\@='

" Wrong: Missing boundary detection
syn match logIPV6 '[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}'

" Correct comments
" IPv6 Address Highlighting
" All IP patterns are inlined in log.vim
```

### Naming Conventions

- **Syntax Groups**: `logXxxYyy` (camelCase, e.g., `logIPV6`, `logTimeZone`)
- **Highlight Links**: Use standard Vim highlight groups (`ErrorMsg`, `Identifier`, `Function`, etc.)
- **Pattern Variables**: Use `s:` prefix (e.g., `s:cpo_save`)
- **Guard Variables**: `b:current_syntax`, `b:current_syntax_ipv6`

### Formatting

- **Indentation**: 2 spaces
- **Line Width**: No hard limit (regex patterns can exceed 120 chars)
- **Blank Lines**: 1-2 between functional blocks
- **Comments**: English only

---

## IPv6 Pattern Design Constraints

### Boundary Detection (MANDATORY)

**All IPv6 patterns must include boundary assertions** to prevent partial matching:

#### Non-`::` Start Patterns (middle/right compression)

```vim
" Start boundary: line start | whitespace | non-IPv6 char
\(^\|\s\|[^:0-9a-fA-F]\)\@<=

" End boundary: non-IPv6 char | line end
\([^:0-9a-fA-F]\|$\)\@=
```

#### `::` Start Patterns (left compression)

```vim
" Start boundary: line start | whitespace | bracket (supports [::1]:8080)
\(^\|\s\|\[\)\@<=::

" End boundary: non-IPv6 char | line end
\([^:0-9a-fA-F]\|$\)\@=
```

### IPv4 Confusion Protection (MANDATORY)

**All pure IPv6 patterns ending with hex segments must include `\(\.\d\)\@!`** to prevent matching `::ffff:999.1.2.3` as `::ffff:999` (since `999` is valid hex).

```vim
" Correct: Added \(\.\d\)\@! to prevent IPv4-mapped prefix matching
syn match logIPV6 '...\{1,4}\(\.\[0-9\]\)\@!\([^:0-9a-fA-F]\|$\)\@='

" Wrong: Missing lookahead, ::ffff:999.1.2.3 partially matches as ::ffff:999
syn match logIPV6 '...\{1,4}\([^:0-9a-fA-F]\|$\)\@='
```

**Rule**: If pattern ends with `[0-9a-fA-F]\{1,4}` (hex segment), insert `\(\.\[0-9\]\)\@!` before end boundary.
Patterns ending with `::` (e.g., `fe80::`) do not need this lookahead.

### Pattern Ordering (CRITICAL)

Vim syntax engine is **left-to-right, first-match-wins**, therefore:

1. **Longest patterns first**: 42 patterns sorted by total length (descending)
2. **Avoid prefix hijacking**: `2001:db8::1` must be defined before `db8::1`
3. **No functions allowed**: `syn match` only supports regex, not VimScript functions

### Avoid E872 Errors

- **Forbidden**: Nested quantifiers `\(\{0,N}\)\{M}`, complex backtracking
- **Recommended**: Explicit enumeration (42 patterns) instead of generic complex regex

---

## Common Issues & Solutions

### 1. Partial Highlighting

**Symptom**: `2001:db8::1` only highlights `db8::1`
**Cause**: Missing pattern covering 2 groups + `::` + 1 group
**Solution**: Add corresponding pattern in `log.vim`, ensure length-based ordering

### 2. Colon Hijacked by logOperator

**Symptom**: `:` in IPv6 address highlighted as operator
**Cause**: `logOperator` contains `\:` character class
**Solution**: Removed `:` from `logOperator` (2026-02-27)

### 3. Number Pattern Conflict

**Symptom**: `2001` matched by `logNumber` or `logHexNumber`, blocking IPv6 match
**Cause**: Number patterns defined before IPv6
**Solution**: IPv6 patterns use boundary assertions for priority matching

### 4. E872 Regex Too Complex

**Symptom**: Vim error `E872: (NFA regexp) Too many '('`
**Cause**: Attempting single regex for all IPv6 formats
**Solution**: Decompose into 42 simple patterns

---

## Modification Workflow

### Modifying IPv6 Rules

1. **Edit only** `syntax/log.vim` (IP patterns inlined, no separate files)
2. Insert new pattern by length (longest first)
3. Add English comment explaining pattern purpose
4. Test in Vim: `vim /path/to/logfile.log`
5. Verify with `:syn list logIPV6`

### Adding New Syntax Rules (Non-IPv6)

1. Edit `syntax/log.vim`
2. Add `syn match` or `syn keyword` at appropriate location
3. Add highlight link: `hi def link logNewGroup HighlightGroup`
4. Test without breaking existing rules

---

## External Resources

- **RFC 5952**: IPv6 Text Representation Standard
  https://datatracker.ietf.org/doc/html/rfc5952
- **Vim Regex Docs**: `:help pattern`, `:help /\@<=`, `:help /\@=`
- **GitHub Repo**: https://github.com/MTDL9/vim-log-highlighting

---

## Technical Constraints

### Vim Limitations

1. `syn match` cannot call functions - regex only
2. Pattern order is critical - longest must come first
3. Avoid E872 errors - keep regex patterns simple

### Debugging Workflow

1. **Incomplete highlighting** → Check for missing length patterns
2. **Partial false matches** → Verify boundary assertions
3. **Performance issues** → Run `:syntime report` to find slow patterns
4. **E872 errors** → Simplify regex, decompose into multiple patterns

---

## Completion Checklist

After modifying IPv6 rules, verify:

- [ ] All IPv6 addresses fully highlighted (no partial matching)
- [ ] IPv4 addresses unaffected (`192.168.1.1`)
- [ ] Numbers not mis-matched (`2001` standalone is number, not IPv6)
- [ ] Colon operators not conflicting (`:` removed from `logOperator`)
- [ ] No E872 errors (regex not too complex)
- [ ] No significant performance degradation (`:syntime report`)

---

**Last Updated**: 2026-02-27 (CIDR prefix support: all 42 patterns end with `\(\/\d\{1,3}\)\?`)
**Status**: Pure IPv6 highlighting complete, CIDR prefix formats (e.g., `2001:db8::1/64`) highlighted, IPv4-mapped formats NOT highlighted (performance priority)
