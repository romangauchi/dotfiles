#!/usr/bin/env bash

wallpaper="/usr/share/wallpapers/Andromeda/contents/images/1920x1200.png"

i3lock -i $wallpaper \
    --clock --ignore-empty-password \
    --radius=120 --ring-width=5 --indicator \
    --layoutcolor=111111ff --datecolor=111111ff --timecolor=111111ff \
    --insidecolor=00000000 --linecolor=00000000 --separatorcolor=00000000 \
    --keyhlcolor=222222aa --bshlcolor=ffb52aaa \
    --ringcolor=ffffff55 \
    --insidewrongcolor=00000000 --wrongcolor=00000000 --ringwrongcolor=ff3936aa \
    --insidevercolor=00000000 --verifcolor=00000000 --ringvercolor=ffb52aaa \
    --wrongtext="" \
    --noinputtext="" \
    --veriftext="Hum..." \
    --locktext="" \
    --lockfailedtext="" \

    # --greetertext="Type password to unlock..." \
    # --greetercolor=222222ff \

