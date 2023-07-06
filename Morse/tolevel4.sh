#!/bin/sh

cat ${1:+"$1"} |
#
# 1: off deltime
# 2: on deltime
#
# Singularize
tr ' ' \\n |
#
# Finally generate text file for -f concat
sed 's/^/duration /' |
awk '
BEGIN{
	# Two images to output
	img[0] = "/Path/To/Projects/common-naruana/white-square.jpg";
	img[1] = "/Path/To/Projects/common-naruana/black-square.jpg";

	state = 0;
}

NR == 1 {
	print "ffconcat version 1.0";
}

{
	# Output
	print "file", img[state];
	state = !state;
	print;
}'
