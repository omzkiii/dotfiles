#!/usr/bin/env bash

LOG_FILE="$HOME/.local/share/tmux/tmux-hook.logs"
# if [[ ! -f $LOG_FILE ]]; then
#     touch $LOG_FILE
#     echo "there is no log file"
# else
#     echo "there is a log file"
# fi
SESSION=$(tmux display-message -p '#S')
if grep -q $1 $LOG_FILE; then
    sed -i "/$1/d" "$LOG_FILE"
    echo "$1 $SESSION" >>$LOG_FILE
elif grep -q $SESSION $LOG_FILE; then
    sed -i "\|$SESSION\|d" "$LOG_FILE"
    echo "$1 $SESSION" >>$LOG_FILE
else
    echo "$1 $SESSION" >>$LOG_FILE
fi
exit 0
