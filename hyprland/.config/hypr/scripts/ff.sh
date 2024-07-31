#!/bin/bash

dir=$(find -P ~/Documents/Projects/ -type d -print0 | fzf --read0 --preview="tree -C -C {}")
name=$(basename "$dir")
if [[ -n "$dir" ]]; then
  if [[ -d "$dir" ]]; then
    if tmux has-session -t $name 2>/dev/null; then
      tmux attach-session -t $name
    else
      tmux new-session -d -s "$name" -c "$dir" "nvim -S Session.vim"
      tmux attach-session -t "$name"
    fi
  else
    echo "Selected directory does not exist: $dir"
  fi
else
  echo "No directory selected."
fi
