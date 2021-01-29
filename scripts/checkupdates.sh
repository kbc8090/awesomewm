#!/bin/bash
upd=$(cat $HOME/.config/awesome/scripts/checktemp)
if [[ $upd -eq 0 ]]
then
	echo -e "None"
else
	echo -e "$upd"
fi
