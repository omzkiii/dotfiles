#!/usr/bin/env sh

TASK_COUNT=$(task count project:Personal status:pending)
TASK_LIST=$(task project:Personal status:pending export | jq -r '.[] | (.description) + " - " + (.urgency * 10 | round / 10 | tostring) + "\\n"')
TASK_DESC=" $TASK_COUNT"
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
