#!/usr/bin/env bash
# source ~/.zshrc
book=$(
	find -P ~/Documents/Books/ -type f | fzf --delimiter / --with-nth -1 --layout=reverse --border=sharp --border-label="󱉟 Books" --pointer=󰄾 --color=16 --color=border:cyan --color=current-bg:bright-black --prompt=" │ " --bind="j:down" --bind="k:up" --bind="i:enable-search+unbind(j)+unbind(k)+unbind(i)" --bind="esc:disable-search+rebind(j)+rebind(k)+rebind(i)"
)

if [[ -n "$book" ]]; then
	nohup zathura --fork "$book" </dev/null
	# echo "$book"
else
	echo "No book selected."
fi
