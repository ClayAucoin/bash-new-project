# newproject.sh

This script creates a new project folder structure inside your `~/class/projects` directory. It sets up common web project files, directories, and boilerplates automatically.

## Overview

The script helps you quickly scaffold a new project with: - A pre-defined directory structure (`css`, `js`, `images`, `.github/workflows`) - Common helper files and templates downloaded automatically - An initialized Git repository with an initial commit

## Usage

Run the script in Git Bash using:

```bash
. newproject.sh lv3/my-project
```

This creates the project folder at:

    ~/class/projects/lv3/my-project/

You can replace `lv3/my-project` with any desired subdirectory path, such as:

```bash
. newproject.sh capstone/movie-watchlist
```

This would create:

    ~/class/projects/capstone/movie-watchlist/

## Structure

After running the script, your folder will look like this:

    my-project/
    ├── index.html
    ├── README.md
    ├── .gitignore
    ├── css/
    │   ├── modal-html-style.css
    │   └── style.css
    ├── images/
    │   └── favicon.ico
    ├── js/
    │   ├── helpers-full.js
    │   ├── helpers-old.js
    │   ├── modal-html.js
    │   ├── my-helpers.js
    │   ├── variables.js
    │   ├── script.js
    │   ├── secret-variables.js
    │   └── app.js
    └── .github/
        └── workflows/
            └── pages.yml

## What It Does

1.  Creates all required directories and files.
2.  Downloads CSS, JS, and GitHub workflow files from your GitHub snippets.
3.  Sets up a `.gitignore` with sensible defaults.
4.  Initializes a Git repository and commits everything with `init`
    message.

## Prerequisites

- **Git Bash** (Windows) or any Unix shell environment
- **curl** command available in your terminal
- Internet connection (to fetch snippet files)

## Notes

- The script uses your home directory `~/class/projects` as the base path.
- You can safely edit the script to point to a different base directory if desired.
- Remember to source the script with a leading dot (`.`) so it runs in your current shell.

Example:

```bash
. newproject.sh lv2/my-awesome-project
```

---

Created by Clay's newproject.sh utility
