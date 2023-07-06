#!/bin/sh

FONT=~/.local/share/fonts/azukiP.ttf
SIZE=40

seq 0 28 |
awk -v font="$FONT" -v size="$SIZE" '
BEGIN{
	WIDTH = 4;
	HEIGHT = 7;

	char[0] = "□";
	char[1] = "■";
}
{
	text = "";
	for ( i = 1; i <= WIDTH * HEIGHT; i++ ){
		str2append = char[ $1 == i ];
		if ( i % WIDTH == 0 && i != WIDTH * HEIGHT ){
			str2append = str2append ORS;
		}
		text = text str2append;
	}

	cmd = sprintf("magick -background transparent -pointsize %d -font %s label:'\''%s'\'' %02d.png",
		size, font, text, $1);

	print cmd;
}'
