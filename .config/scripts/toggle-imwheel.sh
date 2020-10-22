PROGRAM=imwheel
if pgrep imwheel > /dev/null
then
	echo "$PROGRAM is running!\nnow terminating.."
	pkill imwheel
	notify-send -t 2000 "imwheel" "program terminated"
else
	echo "$PROGRAM is not running!\nnow launching $PROGRAM"
	setsid imwheel -b 45 &> /dev/null
	notify-send -t 2000 "imwheel" "program is running"
fi
