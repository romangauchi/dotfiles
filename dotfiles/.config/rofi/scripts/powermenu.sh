#!/usr/bin/env bash

## Author: Roman Gauchi
## Original Author: Aditya Shakya (adi1090x)
## https://github.com/adi1090x/rofi

rofi_command="rofi -theme themes/powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown="襤"
reboot="ﰇ"
lock=""
suspend="鈴"
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        ~/.i3/scripts/locker.sh
        ;;
    $suspend)
        # mpc -q pause
        # amixer set Master mute
        systemctl suspend
        ;;
    $logout)
        i3exit logout
        ;;
esac

