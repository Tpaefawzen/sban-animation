#!/bin/sh

ffmpeg -format concat -safe 0 -i "${1:?}" -r 30 "${2:?}"
