#!/usr/bin/env bash

dual="DualScreens"
singleBigScreen="100"
singleLaptop="singleLaptop"
laptop1080="1080"

response=$(printf "%s %s %s %s" "$dual" "$singleBigScreen" "$singleLaptop" "$laptop1080" | rofi -dmenu -sep " " -selected-row 1 -theme ~/.config/wal/templates/colors-rofi-dark.rasi)

case "$response" in
"$singleBigScreen") autorandr -l 100 --force ;;
"$singleLaptop") autorandr -l singleLaptop --force ;;
"$dual") autorandr -l clone-largest --force ;;
"$laptop1080") xrandr --output eDP --mode "1920x1080_60.00";;
esac
