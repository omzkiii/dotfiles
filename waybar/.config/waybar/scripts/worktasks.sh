#!/usr/bin/env sh

TASK_COUNT="$(task count project:Work status:pending)"
TASK_DESC="󰃖 $TASK_COUNT"
TASK_LIST=$(task project:Work status:pending export | jq -r '.[] | (.description | trim) + " - " + (.urgency * 10 | round / 10 | tostring) + "\\n"')
if [ "$TASK_COUNT" -gt 10 ]; then
	CLASS="high"
elif [ "$TASK_COUNT" -gt 5 ]; then
	CLASS="mid"
elif [ "$TASK_COUNT" -gt 0 ]; then
	CLASS="low"
else
	TASK_DESC=""
fi
echo '{"text": "'$TASK_DESC'", "class": "'$CLASS'", "alt": "personaltask", "tooltip":"'$TASK_LIST'"}'
