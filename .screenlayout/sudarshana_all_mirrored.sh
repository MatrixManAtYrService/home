#!/bin/sh
xrandr --output VIRTUAL1 --off \
    --output DP1 --off \
    --output HDMI1 --off \
    --output VGA1 --off \
    --output DVI-I-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
    --output DVI-I-2-2 --mode 1920x1080 --pos 0x0 --rotate normal \
    --output LVDS1 --off # --mode 1280x720 --pos 0x0 --rotate normal \
