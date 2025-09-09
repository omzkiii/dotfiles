#!/bin/sh

GOVERNOR=$(cpufreqctl.auto-cpufreq -g | tr ' ' '\n' | head -n 1)

output=""
gov=""
case $GOVERNOR in
"performance")
	output="󰓅"
	gov="Performance"
	;;
"balance_power")
	output=""
	gov="Balance"
	;;

"powersave")
	output=""
	gov="Powersave"
	;;
*)
	:
	;;
esac

echo '{"text": "'$output' '$gov'", "class": "cpufreq-'$gov'", "alt": "cpufreq"}'
