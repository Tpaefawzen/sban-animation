#!/bin/sh

ffmpeg -f concat -safe 0 -i "${1:?}" -r 30 "${2:?}"
