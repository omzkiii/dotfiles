#!/bin/bash

local file
file=$(find -P . -type f | fzf -m --preview="bat --color=always {}")
if [[ -n "$file" ]]; then
  cd "$(dirname "$file")"
  nvim "$(basename "$file")"
fi
