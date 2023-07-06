#!/bin/sh

cat ${1:+"$1"} |
#
# 1: "note_[on|off]" 2: note-val 3: delta-time (now in seconds)
#
# I guess convert 2 to 1 to 29
awk '
BEGIN{
	noteval2level[""];

	for ( i = 62; i <= 90; i++ ){
		# shall be 0 to 28
		noteval2level[i] = i - 62;
	}

	# exception
	noteval2level[62] = 1;
}
$2 in noteval2level {
	$2 = noteval2level[$2];
	print;
	next;
}
!( $2 in noteval2level ) {
	print "Unknown note-val: " $2 | "cat 1>&2";
}' |
#
# 1: "note_[on|off]" 2: level 3: delta-time (now in seconds)
#
paste - - |
#
# 1: "note_on" 2: level 3: delta-time (now in seconds)
# 4: "note_off" 5: level 6: delta-time (now in seconds)
#
# Assert if format is as described
#
awk '
$1 == "note_on" && $4 == "note_off" && $2 == $5 {
	print;
	next;
}
{
	print "Record " NR ": WTF?: " $0 | "cat 1>&2";
}' |
#
# 1: "note_on" 2: level 3: delta-time (now in seconds)
# 4: "note_off" 5: level 6: delta-time (now in seconds)
#
# To FFmpeg's concat format
awk '
BEGIN{
	dir = "./img";
	path_template = dir "/" "%02d.png";
}
NR == 1 {
	print "ffconcat version 1.0";
}
{
	# Always print 00.png
	if ( +$3 ){
		path = sprintf(path_template, 0);
		print "file " path;
		print "duration " $3;
	}

	# then
	path = sprintf(path_template, $2);
	print "file " path;
	print "duration " $6;
}'
