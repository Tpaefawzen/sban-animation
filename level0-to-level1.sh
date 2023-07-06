#!/bin/sh

cat Level0/level0.pythonlist |
#
# I want to separate by LFs REALLY.
sed 's/ MidiTrack/\n&/' |
#
# Some names have spaces in them so replacing spaces with underscores
sed 's/1ban kansou no yatsu/1ban_kansou_no_yatsu/' |
sed 's/tenji no yatsu/tenji_no_yatsu/' |
#
# Just space-separated items.
# 2nd operand might need to have more spaces.
tr \''()=][,' ' ' |
#
# Let's work on separating one text into several files separated by each track
awk -v dir='Level1' '
	# Every beginning of track.
	$1 == "MidiTrack"{ msg = $0; next }

	# Buffered output please
	{ msg = msg ORS $0; }
	
	# Finally
	$1 == "MetaMessage" && $2 == "end_of_track" { print( msg) > filename }
	
	# Define file name to be output
	$1 == "MetaMessage" && $2 == "track_name" { filename = dir "/" $4; print(filename); }
'
