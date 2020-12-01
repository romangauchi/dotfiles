#!/usr/bin/env bash

## Author: Roman Gauchi
## Date: November 2020

## Parameters
step=5 # percentage
timeout=1000 # milliseconds

## Generates a progress bar for the provided value.
## from: https://github.com/hastinbe/i3-volume
get_progress_bar() {
    local percent="$1"
    local max_percent=${2:-100}
    local divisor=${3:-5}
    local progress=$((($percent > $max_percent ? $max_percent : $percent) / $divisor))
    printf '█%.0s' $(eval echo "{1..$progress}")
}

## Brightness command
case $1 in
    up)
        xbacklight -inc ${step}
        ;;
    down)
        xbacklight -dec ${step}
        ;;
esac

## Get brightness
level=$(xbacklight -get | xargs printf "%.f")
progress=$(get_progress_bar "$level")
text="$icon $level% $progress"

## send notification (dunst)
notify-send -t $timeout -h string:synchronous:brightness "Brightness $text"

