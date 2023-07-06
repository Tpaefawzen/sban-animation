#!/bin/sh

cat ${1:+"$1"} |
#
# 1: on delta 2: off delta
# unit: ?????
#
awk '
BEGIN{
	# --- consts
	ticks_per_beat = 128; # one quarter has 128 ticks
	tempo = 454545; # in milliseconds
}
{
	for ( i = 1; i <= NF; i++ ){
		# --- how many quarter beats in such length?
		$i /= ticks_per_beat;

		# --- finally to second
		$i *= tempo;
		$i *= 10 ** -6;
	}
	print $0;
}'
