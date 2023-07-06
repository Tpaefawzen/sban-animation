#!/bin/sh

FONT=~/.local/share/fonts/azukiP.ttf
SIZE=200

seq 0 7 |
awk '{
	print int($1/4)%2, int($1/2)%2, int($1/1)%2;
}' |
awk -v font="$FONT" -v size="$SIZE" '
BEGIN{
	char[0] = "　";
	char[1] = "◎";
}
{
	text = "";
	for ( i = 1; i <= NF; i++ ){
		text = text char[$i];
	}

	cmd = sprintf("magick -background transparent -pointsize %d -font %s label:'\''%s'\'' %02d.png",
		size, font, text, NR-1);

	print cmd;
}'
	

# magick -background blue -pointsize 40 -font ~/.local/share/fonts/azukiP.ttf label:@- test.png <<<あああああ

