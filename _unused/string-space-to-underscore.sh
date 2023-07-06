#!/bin/sh

awk -F "'" -v OFS=FS '
{
	for( i = 2; i <= NF; i += 2 ){
		gsub(" ", "_", $i);
	}
}
1
'
