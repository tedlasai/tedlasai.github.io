# Info
This repo contains the files for Sai Tedla's personal website. The site uses
Jekyll to parse yml and markdown files and convert to the html site.

## Local preview
```bash
./serve.sh
```

`serve.sh` rebuilds the CV before starting Jekyll.

## Keeping the CV in sync
Website content and the CV should stay aligned when you change either.

- **Site publications:** `_bibliography/papers.bib`
- **CV sources:** `CV/cv_saitedla.tex` plus `CV/*.bib`
- **Served CV PDF:** `assets/pdf/cv.pdf` (nav "cv" link)

### Automatic PDF rebuild
`bin/build-cv.sh` compiles the CV and copies it to `assets/pdf/cv.pdf`. It runs:

1. On local `./serve.sh`
2. In GitHub Actions before the Jekyll Pages build
3. Via a Cursor `afterFileEdit` hook when these change:
   - `CV/*.{tex,bib}`
   - `_bibliography/papers.bib`
   - `_data/news.yml`
   - `_pages/about.md`

The hook/CI only **rebuild** the PDF from the LaTeX sources. If you change site
news/papers/affiliations, also update the matching CV `.tex`/`.bib` content
when it makes sense (the agent should do this as part of site edits).

Manual rebuild:
```bash
./bin/build-cv.sh
```

Only `.tex` and `.bib` under `CV/` are meant to be committed; LaTeX build
artifacts there are gitignored. `assets/pdf/cv.pdf` is the published copy.

## File encoding (UTF-8 required)
All text sources in this repo **must be UTF-8** (YAML, shell scripts, Markdown,
HTML, TeX, BibTeX, etc.). GitHub Actions and Jekyll will fail or misparse files
saved as UTF-16.

### Known issue
Some editors or sync tools occasionally rewrite files as UTF-16. The file can
still look fine in the editor, but GitHub reports `Invalid workflow file` /
YAML syntax errors (especially for `.github/workflows/pages.yml`), and scripts
like `serve.sh` may fail with `cannot execute binary file`.

**Fix — convert back to UTF-8:**
```bash
# Check (UTF-16 often shows as "data"; UTF-8 shows as "ASCII text" / "UTF-8")
file .github/workflows/pages.yml serve.sh

# Convert a UTF-16 file to UTF-8
python3 -c "
from pathlib import Path
p = Path('.github/workflows/pages.yml')  # or another path
p.write_bytes(p.read_bytes().decode('utf-16').encode('utf-8'))
"
```

Re-check with `file …` (should be ASCII/UTF-8 text), then commit and push.

# Licensing
This work is distributed under the MIT license with portions modified from
the [al-folio jekyll theme](https://github.com/alshedivat/al-folio) distributed by alshedivat.
