#!/bin/sh

MONITOR1=DP-0
MONITOR2=DP-2

xrandr --output "${MONITOR2}" --primary --left-of "${MONITOR1}" --auto
trap "xrandr --output '${MONITOR1}' --primary --left-of '${MONITOR2}'" EXIT
"${@}"
