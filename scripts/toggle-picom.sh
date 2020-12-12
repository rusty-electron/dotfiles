PROGRAM=picom
if pgrep $PROGRAM > /dev/null
then
	echo "$PROGRAM is running!\nnow terminating.."
	pkill $PROGRAM
	notify-send -t 2000 "picom terminated" "transparency disabled"
else
	echo "$PROGRAM is not running!\nnow launching $PROGRAM"
	setsid picom &
	notify-send -t 2000 "$PROGRAM is running" "transparency enabled"
fi
