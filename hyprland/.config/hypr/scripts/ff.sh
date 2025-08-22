#!/usr/bin/env bash
CONF_FILE="$HOME/.config/hypr/opacity.conf"
OPACITY=$(sed -n 's/^\$opacity *= *\([0-9.]*\).*/\1/p' "$CONF_FILE")

HISTORY_FILE="$HOME/.fzf_project_history"

dir=$(
  (
    cat "$HISTORY_FILE"
    # fd -t d --base-directory ~/Documents/Projects/
    find -P ~/Documents/Projects/ -type d
  ) | fzf --preview="tree -C -C {}" --delimiter / --with-nth 6.. --layout=default --border=sharp --preview-border=sharp --border-label=" Projects" --pointer=󰄾 --color=16 --color=border:cyan --color=current-bg:bright-black --prompt=" │" --bind="j:down" --bind="k:up" --bind="q:abort" --bind="i:enable-search+unbind(j)+unbind(k)+unbind(i)+unbind(q)" --bind="esc:disable-search+rebind(j)+rebind(k)+rebind(i)+rebind(q)"
)

# name=$(basename "$dir")
name="$(basename "$(dirname "$dir")")/$(basename "$dir")"

if [[ -n "$dir" ]]; then

  tmp_history=$(mktemp) # Create a temporary file
  {
    echo "$dir"
    grep -Fxv "$dir" "$HISTORY_FILE"
  } | sed '/^$/d' | head -n 5 >"$tmp_history"
  mv "$tmp_history" "$HISTORY_FILE" # Replace history file safely

  if [[ -d "$dir" ]]; then
    if tmux list-clients | grep "attached"; then
      if tmux has-session -t $name 2>/dev/null; then
        tmux switch-client -t "$name"
        hyprctl dispatch focuswindow title:tmux
      else
        tmux new-session -d -s "$name" -c "$dir" "zsh -i -c 'nvim -S Session.vim; exec zsh'"
        tmux switch-client -t "$name"
        hyprctl dispatch focuswindow title:tmux
      fi
    else
      if tmux has-session -t $name 2>/dev/null; then
        kitty -o background_opacity=$OPACITY --detach tmux attach-session -t "$name"
      else
        tmux new-session -d -s "$name" -c "$dir" "zsh -i -c 'nvim -S Session.vim; exec zsh'"
        kitty -o background_opacity=$OPACITY --detach tmux attach-session -t "$name"
      fi
    fi
  else
    echo "Selected directory does not exist: $dir"
  fi
else
  echo "No directory selected."
fi
# kill -9 $PPID
