#!/bin/bash

for output in $(xrandr | grep '\Wconnected' | awk '{ print $1 }'); do
    if [[ $output =~ ^HDMI.*$ ]]; then
            hdmi=$output
    fi
done
for output in $(xrandr | grep '\Wconnected' | awk '{ print $1 }'); do
    if [[ $output =~ ^eDP.*$ ]]; then
       #xrandr --output $hdmi --auto --output $output --pos 0x0 --auto --right-of $hdmi --primary
       xrandr --output $hdmi --mode 1920x1080 --primary --output $output --off
    fi
done
