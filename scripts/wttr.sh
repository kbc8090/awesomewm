#!/bin/bash

#weather="$(curl -s "wttr.in/Gainesville?format=3")"
#echo "$weather "

WEATHER=$(curl -s 'wttr.in/Gainesville?format=1&u' | sed 's/ //g' | sed 's/+//g')
WTEXT=$(grep -o "[0-9].*" <<< "$WEATHER")
WICON=${WEATHER:0:1}

echo -e "$WICON $WTEXT " 
