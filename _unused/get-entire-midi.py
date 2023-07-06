#!/usr/bin/env python

import mido

MIDIFILENAME = "hoge.mid"

m = mido.MidiFile(MIDIFILENAME)
print(m)
