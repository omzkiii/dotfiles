#!/usr/bin/env sh

SESSIONS=$(tmux list-sessions -F "#S" | jq -Rr '[.,inputs] | join("\\n")')
SESSIONS_COUNT=$(tmux list-sessions -F "#S" | awk 'END {print NR}')
LABEL=" $SESSIONS_COUNT"
if [ $SESSIONS_COUNT -lt 1 ]; then
	LABEL=""
fi
echo '{"text": "'$LABEL'", "class": "tmux-sessions", "alt": "personaltask", "tooltip":"'$SESSIONS'"}'
