#!/bin/sh

cat ${1:+"$1"} |
#
# 1: braille value 2: DURATION TIME (not delta-time anymore)
#
awk '
BEGIN{
	dir = "./img";
	pathTemplate = dir "/" "%02d.png";
}

NR == 1 {
	print "ffconcat version 1.0";
}

{
	path = sprintf(pathTemplate, $1);
	print "file " path;
	print "duration " $2;
}'
