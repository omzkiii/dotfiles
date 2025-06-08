#!/bin/bash

HISTORY_FILE="$HOME/.fzf_project_history"
# awk '!seen[$0]++' "$HISTORY_FILE" | sed '/^$/d' >"$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
# dir=$(find -P ~/Documents/Projects/ -type d -print0 | fzf --read0 --preview="tree -C -C {}")

dir=$( (
  cat "$HISTORY_FILE"
  find -P ~/Documents/Projects/ -type d
) | fzf --preview="tree -C -C {}")

name=$(basename "$dir")

if [[ -n "$dir" ]]; then

  tmp_history=$(mktemp) # Create a temporary file
  {
    echo "$dir"
    grep -Fxv "$dir" "$HISTORY_FILE"
  } | sed '/^$/d' | head -n 5 >"$tmp_history"
  mv "$tmp_history" "$HISTORY_FILE" # Replace history file safely

  if [[ -d "$dir" ]]; then
    if [ -n "$TMUX" ]; then
      if tmux has-session -t $name 2>/dev/null; then
        tmux switch-session -t $name
      else
        tmux new-session -d -s "$name" -c "$dir" "nvim -S Session.vim"
        tmux switch-session -t "$name"
    else
      if tmux has-session -t $name 2>/dev/null; then
        tmux attach-session -t $name
      else
        tmux new-session -d -s "$name" -c "$dir" "nvim -S Session.vim"
        tmux attach-session -t "$name"
      fi
    fi
  else
    echo "Selected directory does not exist: $dir"
  fi
else
  echo "No directory selected."
fi
