#! /usr/bin/bash
# Quick Demo: https://imgur.com/a/Gd08qhK
# Opening a new tab (or looking for my open poe.ninja tab) each time bothered me, so I made a small script that uses jq to parse poe.ninja data and rofi to show a menu of different item types. 
# Selecting that item type shows you a list of prices.
#
# Make sure jq and rofi are installed.


league="Affliction"
declare -a item_type=("DeliriumOrb" "Scarab" "Currency" "Fragment" "Oil" "Essence" "Fossil" "DivinationCard" "UniqueWeapon")

selection=$(printf '%s\n' "${item_type[@]}" | rofi -dmenu -i)
# there are 2 main endpoints: /itemoverview and /currencyoverview
url="https://poe.ninja/api/data/itemoverview?league=$league&type=$selection"
url2="https://poe.ninja/api/data/currencyoverview?league=$league&type=$selection"

case $selection in
  Currency | Fragment)
    curl -s "$url2" | jq -r '.lines[] | .currencyTypeName + "*" + (.receive.value|tostring[0:6]) + "c"' | column -ts "*" | rofi -dmenu -i;;
  DeliriumOrb | Scarab | Oil | Essence | Fossil | DivinationCard | UniqueWeapon)
    curl -s "$url" | jq -rc '.lines[] | .name + " - " + (.chaosValue | tostring) + "c - " + (.divineValue | tostring) + "d"' | column -ts "-" | rofi -dmenu -i;;
esac

