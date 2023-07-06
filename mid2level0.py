#!/usr/bin/env python

# python3

import mido

# CONFIGURE THIS LIST
midiFileName = 'hoge.mid'
requiredTrackNames = ['tenji no yatsu', 'morseLeft', 'morseRight', '1ban kansou no yatsu']
outputFileName = 'level0.pythonlist'

m = mido.MidiFile(midiFileName)

# i want these items
requiredTracks = []
for x in m.tracks:
	if x.name in requiredTrackNames:
		requiredTracks.append(x)

# finally
with open(outputFileName, "w") as f:
	print(requiredTracks, file=f)

# leave other jobs to shell script
