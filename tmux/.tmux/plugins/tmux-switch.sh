#!/usr/bin/env bash

# mapfile -t SESSIONS < <(tmux list-sessions -F"#D #S" | sort)

mapfile -t SESSIONS < <(tmux list-sessions -F"#D #S" | sort | awk '{print $3, $2}')
mapfile -t SORTED < <(
    printf "%s\n" "${SESSIONS[@]}" |
        awk '
      /^[0-9]/ { print > "/tmp/numeric"; next }
      { print > "/tmp/non_numeric" }
    ' &&
        {
            sort /tmp/numeric | awk '{print $2}'
            cat /tmp/non_numeric
            rm /tmp/numeric /tmp/non_numeric
        }
)

if [[ ${#SORTED[@]} -lt $1 ]]; then
    exit 0
else
    CLIENT=$(echo "${SORTED[$1]}")
    tmux switch-client -t $CLIENT
fi
exit 0
