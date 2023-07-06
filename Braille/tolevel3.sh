#!/bin/sh

cat ${1:+"$1"} |
#
# 1: "note_[on|off]" 2: note-val 3: delta-time (now in seconds)
#
awk '
BEGIN{
	note2pos[65] = 1;
	note2pos[69] = 2;
	note2pos[72] = 4;
}
$2 in note2pos {
	$2 = note2pos[$2];
	print;
	next;
}
{
	print "Record " NR ": WTF?: " $0 | "cat 1>&2";
}' |
#
# 1: "note_{on|off}" 2: braille-point 3: delta-time in seconds
#
# note_off to 0
awk '
$1 == "note_off" { $2 = 0; }
1' |
#
# 1: "note_{on|off}" 2: braille-point 3: delta-time in seconds
#
# group and numberize
awk '
NR == 1 {
	fst = $1;
	previousVal = 0;
}
$1 != fst {
	print previousVal, deltaTime

	fst = $1;
	previousVal = val;
	val = 0;
	deltaTime = "";
}
{
	val += $2;
	if ( deltaTime == "" ){
		deltaTime = $3;
	} else if ( $3 == 0 ) {
		# NOP
	} else if ( deltaTime != $3 ) {
		print "Record " NR ": deltaTime contradiction: " deltaTime " vs " $3 | "cat 1>&2";
	}
}
END {
	print previousVal, deltaTime
}' |
#
# 1: braille value 2: DURATION TIME (not delta-time anymore)
#
# Now it's suitable for FFmpeg concat!
# Duration time needs to be nonzero
awk '$2 > 0'
