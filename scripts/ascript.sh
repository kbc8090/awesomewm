#!/bin/sh

ACTION=$(printf "No\nYes" | dmenu -i -c -bw 2 -h 35 -fn "JetBrains Mono:size=13:style=Bold" -nf "#a8b4ff" -sb "#ffb26b" -sf "#24283b" -nb "#24283b" -p "Quit Awesome?")

case "$ACTION" in
  "Yes")
    awesome-client "awesome.quit()" ;;
esac
