#!/bin/bash

list="Master Headphone Front"

if amixer sget Master | grep '\[off\]' > /dev/null; then
    cmd=unmute
else
    cmd=mute
fi

for entry in $list; do
    amixer -q sset $entry $cmd
done
