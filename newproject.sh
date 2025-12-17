#!/usr/bin/env bash
set -euo pipefail

BASE_DIR=~/class/projects

if [ -z "${1:-}" ]; then
  echo "Usage: newproject <subdir/project-name>"
  echo "Example: newproject lv3/my-project"
  exit 1
fi

REL_PATH="$1"
PROJECT_PATH="$BASE_DIR/$REL_PATH"
PROJECT_NAME="$(basename "$REL_PATH")"

mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"

# ----------------------------
# Helpers
# ----------------------------
write_gitignore() {
  cat > .gitignore <<'GITIGNORE_EOF'
# See https://help.github.com/articles/ignoring-files/ for more about ignoring files.

# dependencies
/node_modules
/.pnp
pnp.js

# editor / logs
.vscode/

# testing
/coverage

# production
/build

# virtual environment directories
env/
venv/
ENV/
.env
.env.test
env*
ENV*
.venv/
secret-variables.js

# logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# OS cruft
.DS_Store
Thumbs.db
#---
GITIGNORE_EOF
}

ensure_common_files() {
  touch README.md .env
  write_gitignore
}

git_init_commit() {
  if [ ! -d ".git" ]; then
    git init >/dev/null
  fi

  git add . >/dev/null

  # Only commit if there is something staged
  if git diff --cached --quiet; then
    : # nothing to commit
  else
    git commit -m "init" >/dev/null
  fi
}

download_if_missing() {
  # download_if_missing <url> <dest_path>
  local url="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"
  if [ -f "$dest" ]; then
    return 0
  fi
  curl -fsSL -o "$dest" "$url"
}

# ----------------------------
# Menu
# ----------------------------
echo
echo "Select a project template:"
echo
echo "1. HTML"
echo "2. Express.js"
echo "3. React project (Vite)"
echo "4. Empty project"
echo

read -rp "Choose a template (1-4): " choice

case "$choice" in
  1)
    # ----------------------------
    # HTML template
    # ----------------------------
    ensure_common_files

    touch index.html
    mkdir -p css images js .github/workflows

    # css
    download_if_missing "https://clayaucoin.github.io/snippets/css/modal-html-style.css" "css/modal-html-style.css"
    touch css/style.css

    # images
    download_if_missing "https://clayaucoin.github.io/snippets/images/favicon.ico" "images/favicon.ico"

    # js
    download_if_missing "https://clayaucoin.github.io/snippets/js/helpers-full.js" "js/helpers-full.js"
    download_if_missing "https://clayaucoin.github.io/snippets/js/helpers-old.js"  "js/helpers-old.js"
    download_if_missing "https://clayaucoin.github.io/snippets/js/modal-html.js"   "js/modal-html.js"
    download_if_missing "https://clayaucoin.github.io/snippets/js/my-helpers.js"   "js/my-helpers.js"
    touch js/script.js js/app.js

    # GitHub Actions
    download_if_missing "https://clayaucoin.github.io/snippets/yml/pages.yml" ".github/workflows/pages.yml"

    git_init_commit
    echo "HTML project '$PROJECT_NAME' created in $PROJECT_PATH"
    ;;

  2)
    # ----------------------------
    # Express.js template
    # ----------------------------
    ensure_common_files

    touch app.js index.js
    mkdir -p src src/controllers src/middleware src/routes src/utils

    git_init_commit
    echo "Express project '$PROJECT_NAME' created in $PROJECT_PATH"
    ;;

  3)
    # ----------------------------
    # React (Vite) template
    # ----------------------------
    # Common files first (so .env exists even if vite doesn't create it)
    ensure_common_files

    # If the folder isn't empty, Vite may refuse. We'll allow a basic safeguard.
    # (README/.gitignore/.env are already here, which is fine in practice, but can trip older tooling.)
    # We'll run Vite anyway; if it fails, you'll see the error.
    if ! command -v npm >/dev/null 2>&1; then
      echo "ERROR: npm is required for the React template."
      exit 1
    fi

    # Scaffold react app into current directory
    npm create vite@latest . -- --template react

    # Your extra folder + favicon (you asked for images/ at root)
    mkdir -p images
    download_if_missing "https://clayaucoin.github.io/snippets/images/favicon.ico" "images/favicon.ico"

    # Also drop favicon where browsers expect it for Vite:
    mkdir -p public
    download_if_missing "https://clayaucoin.github.io/snippets/images/favicon.ico" "public/favicon.ico"

    git_init_commit
    echo "React (Vite) project '$PROJECT_NAME' created in $PROJECT_PATH"
    ;;

  4)
    # ----------------------------
    # Empty project
    # ----------------------------
    echo "Empty project '$PROJECT_NAME' folder created at $PROJECT_PATH"
    echo "You are now in: $(pwd)"
    ;;

  *)
    echo "Invalid choice. Run again and choose 1-4."
    exit 1
    ;;
esac
