#!/bin/sh

pactl list sinks | nawk '/Volume: front-left:/ {print $5 " "}'
