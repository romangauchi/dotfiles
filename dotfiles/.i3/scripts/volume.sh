#!/usr/bin/env bash

## Author: Roman Gauchi
## Date: May 2020

## Parameters
step=5 # percentage
timeout=1000 # milliseconds

## Icons
icon_up="ﱛ"
icon_down="ﱜ"
icon_muted="ﱝ"

## Generates a progress bar for the provided value.
## from: https://github.com/hastinbe/i3-volume
get_progress_bar() {
    local percent="$1"
    local max_percent=${2:-100}
    local divisor=${3:-5}
    local progress=$((($percent > $max_percent ? $max_percent : $percent) / $divisor))
    printf '█%.0s' $(eval echo "{1..$progress}")
}

## Volume command
case $1 in
    toggle)
        channels="Master Headphone Front"
        if amixer sget Master|grep '\[off\]' &> /dev/null; then
            mute_cmd="unmute"
        else
            mute_cmd="mute"
        fi
        for entry in $channels; do
            amixer -Mq set $entry $mute_cmd &> /dev/null
        done
        icon=$ICON_MUTED
        ;;
    up)
        amixer -Mq set Master,0 ${step}%+ unmute
        icon=$ICON_UP
        ;;
    down)
        amixer -Mq set Master,0 ${step}%- unmute
        icon=$ICON_DOWN
        ;;
esac

## Get volume
if [[ ! -z $mute_cmd && $mute_cmd == "mute" ]]; then
    text="Muted"
else
    volume="$(amixer get Master|tail -n1|awk -F ' ' '{print $5}' | tr -d '[]%')"
    progress=$(get_progress_bar "$volume")
    text="$icon $volume% $progress"
fi

## send notification (dunst)
notify-send -t $timeout -h string:synchronous:volume "Volume $text"

