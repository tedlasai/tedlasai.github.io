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

# Licensing
This work is distributed under the MIT license with portions modified from
the [al-folio jekyll theme](https://github.com/alshedivat/al-folio) distributed by alshedivat.
