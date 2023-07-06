#!/bin/sh

set -eu
umask 0022
export LC_ALL=C
if _p="$( command -p getconf PATH 2>/dev/null)"; then
	export PATH="$_p${PATH+:}${PATH:-}"
fi
export UNIX_STD=2003
export POSIXLY_CORRECT=1

for x in ./Level1/morseLeft ./Level1/morseRight; do
	cat "$x" |
	#
	# Remove meta messages
	sed '1,3d' |
	awk '$1 == "Message"' |
	#
	# 1-NF:
	# Message note_[on|off] channel VALUE note VALUE velocity VALUE time VALUE
	# OBTW note_on and note_off shall be alternatively
	#
	# I want final delta time
	awk -v fst_time_delta=25088 ' # value is as in morseLeft-s first Message-s delta time
		NR == 1 { $NF -= fst_time_delta; } # to prevent video from being WAY TOO LONG
		{ print $NF }
	' |
	#
	# VALUE
	paste - - > Morse/"${x##*/}".level2
done
