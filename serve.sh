#!/usr/bin/env bash
# Local preview helper for Apple Silicon + Intel Homebrew Ruby (/usr/local).
# Clang defaults to arm64 even under Rosetta, so we wrap it to force x86_64.
set -euo pipefail
cd "$(dirname "$0")"

RUBY_PREFIX="/usr/local/opt/ruby@3.3"
if [[ ! -x "$RUBY_PREFIX/bin/ruby" ]]; then
  RUBY_PREFIX="/usr/local/opt/ruby"
fi
if [[ ! -x "$RUBY_PREFIX/bin/ruby" ]]; then
  echo "Could not find Homebrew Ruby at /usr/local/opt/ruby@3.3 or /usr/local/opt/ruby" >&2
  exit 1
fi

WRAP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/jekyll-x86clang.XXXXXX")"
cleanup() { rm -rf "$WRAP_DIR"; }
trap cleanup EXIT

cat > "$WRAP_DIR/clang" <<'EOF'
#!/bin/bash
exec /usr/bin/clang -arch x86_64 "$@"
EOF
cat > "$WRAP_DIR/clang++" <<'EOF'
#!/bin/bash
exec /usr/bin/clang++ -arch x86_64 "$@"
EOF
chmod +x "$WRAP_DIR/clang" "$WRAP_DIR/clang++"

export PATH="$WRAP_DIR:$RUBY_PREFIX/bin:$PATH"
# Avoid RVM's ancient Ruby taking over
unset GEM_HOME GEM_PATH

if ! bundle check >/dev/null 2>&1; then
  echo "Installing gems (first run or after Gemfile changes)..."
  arch -x86_64 bundle install
fi

# Keep the nav CV PDF in sync with CV/ sources
./bin/build-cv.sh || echo "Warning: CV rebuild skipped/failed; using existing assets/pdf/cv.pdf" >&2

echo "Serving at http://127.0.0.1:4000"
arch -x86_64 bundle exec jekyll serve --livereload --host 127.0.0.1 --port 4000 "$@"
