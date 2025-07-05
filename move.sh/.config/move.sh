#!/usr/bin/env bash

# CONFIG
CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"

# List of excluded configs (from your .gitignore)
EXCLUDES=(
  "Code"
  "Cursor"
  "coc"
  "spotify"
  "Vencord"
  "vivaldi"
  "MongoDB Compass"
  "nextjs-nodejs"
  "Termius"
  "create-next-app"
  "dconf"
  "Electron"
  "Exodus"
  "JetBrains"
  "github-copilot"
  "discordptb"
  "discordcanary"
  "discord"
  "create-next-app-nodejs"
  "obsidian"
)

# Function to check if an item is in EXCLUDES
is_excluded() {
  local item="$1"
  for exclude in "${EXCLUDES[@]}"; do
    if [[ "$exclude" == "$item" ]]; then
      return 0
    fi
  done
  return 1
}

# MAIN
cd "$CONFIG_DIR" || exit

for item in *; do
  # Check exclusion
  if is_excluded "$item"; then
    echo "Skipping excluded: $item"
    continue
  fi

  echo "Moving $item to dotfiles..."

  # Create stow-friendly structure
  mkdir -p "$DOTFILES_DIR/$item/.config"

  # Move
  mv "$item" "$DOTFILES_DIR/$item/.config/"
done

echo "✅ Done. You can now stow them back with:"

echo 'cd ~/dotfiles'
echo 'for dir in */ ; do stow "$dir"; done'
