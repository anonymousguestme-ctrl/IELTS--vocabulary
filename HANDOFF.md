# Handoff｜IELTS Vocabulary Bench

## 1. Project Identity

- Project: `IELTS Vocabulary Bench｜本地的雅思单词本`
- Repository: https://github.com/anonymousguestme-ctrl/IELTS--vocabulary
- Local path: `/Users/adele/Desktop/IELTS- vocabulary`
- Branch: `main`
- Latest commit: `a68b204 feat: edit vocabulary cards`

This is a static, browser-only IELTS vocabulary tracker. It can be opened directly from `index.html`; no package manager, build step, backend, or account is required.

## 2. Delivered Features

### Vocabulary records

Each record stores an English entry, part of speech, Chinese meaning, optional phrases, optional example sentence, and mastered status. New records and status changes are stored in browser `localStorage`.

### Offline lookup

Lookup order is local cache, the Excel-derived dictionary, the `fanhongtao/IELTS` dictionary, the `hefengxian/my-ielts` dictionary, and finally the public `dictionaryapi.dev` endpoint. Network lookup has a four-second timeout. Local hits work without internet.

### Part-of-speech control

The part-of-speech field is a select control with common values such as noun, verb, adjective, adverb, preposition, conjunction, phrase, combined parts of speech, other, and pending confirmation. Imported values that cannot be safely inferred are shown as `待确认`, not `IELTS 词汇`.

### Review workflow

- Filter by all, not mastered, or mastered.
- Search by English entry, meaning, or phrase.
- Mark a card mastered using its checkbox.
- Use the global `隐藏释义` / `显示释义` button to self-test.
- Print the current list. Print CSS hides editing controls and mastered cards.
- Empty phrase and sentence rows are automatically hidden.
- Click a vocabulary card to load it into the left form, edit its fields, and save the existing record. Checkbox, delete, and other buttons do not trigger editing.

## 3. Vocabulary Data

The repository contains three static dictionary files:

| File | Source | Approximate entries |
| --- | --- | ---: |
| `ielts-dictionary.js` | Local `语料库练习模板(剑19)-2025.7.6.xlsx` | 5,222 |
| `repo-ielts-dictionary.js` | `fanhongtao/IELTS` `IELTS Word List.txt` | 3,589 |
| `hf-ielts-dictionary.js` | `hefengxian/my-ielts` vocabulary module | 3,697 |

The dictionaries are loaded before `app.js` in `index.html`. `app.js` merges them without replacing the curated entries in its small hand-maintained dictionary.

## 4. File Map

```text
index.html                  Static page markup
styles.css                  Interface, responsive, and print styles
app.js                      UI state, lookup, persistence, filtering, printing
ielts-dictionary.js         Excel-derived dictionary
repo-ielts-dictionary.js    fanhongtao/IELTS-derived dictionary
hf-ielts-dictionary.js      hefengxian/my-ielts-derived dictionary
README.md                   User-facing project documentation
HANDOFF.md                  This engineering handoff
notes.md                    Working notes
task_plan.md                Original implementation plan
screenshot.jpg              Original local screenshot asset (not referenced by README)
docs/                       Cropped screenshot assets retained in the repository
```

## 5. How To Run

```bash
open "/Users/adele/Desktop/IELTS- vocabulary/index.html"
```

For a local HTTP server, use any static server pointed at the project directory. The app does not require one, but HTTP hosting may make browser storage behavior more predictable across browsers.

## 6. Verification Completed

- `node --check app.js` passed.
- `node --check ielts-dictionary.js` passed.
- `node --check repo-ielts-dictionary.js` passed.
- `node --check hf-ielts-dictionary.js` passed.
- GitHub `main` branch contains the latest commit.
- README and dictionary assets were checked through GitHub raw URLs during the session.
- Working tree was clean after the last push.

## 7. Known Limitations

1. The current form is optimized for adding a word with optional phrase and sentence fields. A dedicated mode for independently adding a phrase or sentence has not yet been implemented.
2. Automatic topic/category classification has not yet been implemented.
3. The imported dictionaries include examples and source metadata, but the current lookup form fills only part of speech and meaning automatically.
4. Part-of-speech inference based on spelling endings is heuristic. Review `待确认` and combined values before relying on them.
5. User records are browser-local. Clearing site data or switching browsers can make them unavailable.
6. The public dictionary fallback requires network access and may be blocked by local network policy.
7. The repository retains screenshot assets, but the README currently contains no image embeds by request.

## 8. Recommended Next Work

### P0: Independent phrase and sentence entries

Add an entry-type selector (`单词`, `短语`, `句子`) to the form. For phrases, use the same local lookup and save the entry as `kind: "phrase"`; for sentences, skip lookup and save the sentence as `kind: "sentence"`.

### P1: Topic classification

Add a `category` field and a category filter. Start with a small controlled vocabulary such as `电影影视`, `环境自然`, `教育学习`, `科技互联网`, `社会公共`, `健康生活`, `旅行交通`, `工作经济`, `文化艺术`, `科学医学`, `人物地点`, and `未分类`. Add keyword rules only after reviewing false matches.

### P1: Import/export

Add JSON export and import so browser-local records can be backed up and moved to another device.

### P2: Better source mapping

Preserve the source repository's topic, example, and extra fields in the card model, then expose them as optional card details instead of discarding them during lookup.

## 9. Change History

- `febf668` initial offline vocabulary bench
- `b80c813` per-card definition toggle (later replaced by global toggle)
- `1806a60` README title and screenshot
- `ee4ce0a` global definition toggle and aligned card layout
- `36fbf34` hefengxian/my-ielts vocabulary source
- `f3ea36e` remove README image embeds
- `a1e62dc` normalize imported parts of speech
- `a9ae1be` add part-of-speech selector
- `a68b204` add vocabulary card editing

## 10. Handoff Checklist

- [x] Desktop copy exists at `/Users/adele/Desktop/IELTS- vocabulary`.
- [x] Remote `origin` points to `anonymousguestme-ctrl/IELTS--vocabulary`.
- [x] Latest local commit is pushed to `origin/main`.
- [x] README has been updated without image embeds.
- [x] Dictionary files are loaded by the page.
- [x] Current limitations are documented above.
