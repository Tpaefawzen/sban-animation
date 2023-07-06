#!/bin/sh


tr -s "',=()][" ' ' |
awk -v trackNo=-1 '
$1 == "MetaMessage" || $1 == "Message" {
	$0 = "Track" FS trackNo FS $0;
}
$1 == "MidiTrack" {
	trackNo++;
	next;
}
1'
