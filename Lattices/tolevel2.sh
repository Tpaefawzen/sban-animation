#!/bin/sh

FIRST_DELTA_TIME_NEEDS_TO_BE=2

cat ${1:+"$1"} |
awk '$1 == "Message"' |
#
# 1-10
# 1: "Message" 2: "note_[on|off]" 3: "channel" 4: channel-id 5: "note"
# 6: note-val 7: "velocity" 8: velocity 9: "time" 10:delta-time
#
# OBTW channel-id, velocity were common for every record
self 2 6 10 |
#
# 1: "note_[on|off]" 2: note-val 3: delta-time
#
awk '
BEGIN{
	# --- consts
	ticks_per_beat = 128; # one quarter has 128 ticks
	tempo = 454545; # in milliseconds
}
{
	# --- how many quarter beats in such length?
	$3 /= ticks_per_beat;
	
	# --- to second
	$3 *= tempo;
	$3 *= 10 ** -6;

	print $0;
}' |
#
# 1: "note_[on|off]" 2: note-val 3: delta-time (now in seconds)
#
# I prefer first delta time to be 2 seconds
case "$FIRST_DELTA_TIME_NEEDS_TO_BE" in
?*)
	awk -v t="$FIRST_DELTA_TIME_NEEDS_TO_BE" 'NR == 1{ $3 = t; } 1'
	;;
'')
	cat
	;;
esac
