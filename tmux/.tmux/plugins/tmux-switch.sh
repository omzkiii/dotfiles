#!/usr/bin/env bash

LOG_FILE="$HOME/.local/share/tmux/tmux-hook.logs"

TARGET=$(grep "$1" $LOG_FILE | awk '{print $2}')
tmux switch-client -t $TARGET
exit 0

# mapfile -t SESSIONS < <(tmux list-sessions -F"#D #S" | sort | awk '{print $2}')

# mapfile -t SESSIONS < <(tmux list-sessions -F"#D #S" | sort | awk '{print $3, $2}')
# mapfile -t SORTED < <(
#     printf "%s\n" "${SESSIONS[@]}" |
#         awk '
#       /^[0-9]/ { print > "/tmp/numeric"; next }
#       { print > "/tmp/non_numeric" }
#     ' &&
#         {
#             sort /tmp/numeric | awk '{print $2}'
#             cat /tmp/non_numeric
#             rm /tmp/numeric /tmp/non_numeric
#         }
# )

# if [[ ${#SESSIONS[@]} -lt $1 ]]; then
#     exit 0
# else
#     CLIENT=$(echo "${SESSIONS[$1]}")
#     tmux switch-client -t $CLIENT
# fi
# exit 0
