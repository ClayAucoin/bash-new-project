#!/bin/bash
set -euo pipefail

BASE_DIR=~/class/projects

if [ -z "${1:-}" ]; then
  echo "Usage: newproject <subdir/project-name>"
  echo "Example: newproject lv3/my-project"
  exit 1
fi

# Take input like lv3/my-project
REL_PATH=$1
PROJECT_PATH="$BASE_DIR/$REL_PATH"
PROJECT_NAME=$(basename "$REL_PATH")

mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"

# root files/dirs
touch index.html README.md .gitignore
mkdir -p css images js .github/workflows

# css
curl -fsSL -o css/modal-html-style.css https://clayaucoin.github.io/snippets/css/modal-html-style.css
touch css/style.css

# images
curl -fsSL -o images/favicon.ico https://clayaucoin.github.io/snippets/images/favicon.ico

# js
curl -fsSL -o js/helpers-full.js      https://clayaucoin.github.io/snippets/js/helpers-full.js
curl -fsSL -o js/helpers-old.js       https://clayaucoin.github.io/snippets/js/helpers-old.js
curl -fsSL -o js/modal-html.js        https://clayaucoin.github.io/snippets/js/modal-html.js
curl -fsSL -o js/my-helpers.js        https://clayaucoin.github.io/snippets/js/my-helpers.js
curl -fsSL -o js/variables.js         https://clayaucoin.github.io/snippets/js/variables.js
touch js/script.js js/secret-variables.js js/app.js

# GitHub Actions
curl -fsSL -o .github/workflows/pages.yml https://clayaucoin.github.io/snippets/yml/pages.yml

# .gitignore
cat > .gitignore <<'GITIGNORE_EOF'
# See https://help.github.com/articles/ignoring-files/ for more about ignoring files.

# dependencies
/node_modules
/.pnp
.pnp.js

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

git init
git add .
git commit -m "init"

echo "Project '$PROJECT_NAME' created and initialized in $PROJECT_PATH"
