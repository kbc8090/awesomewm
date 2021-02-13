#!/bin/bash
upd=$(cat $HOME/.config/awesome/scripts/checktemp | wc -l)
if [[ $upd -eq 0 ]]
then
	echo -e "No Updates"
elif [[ $upd -eq 1 ]]
then
	echo -e "$upd Update"
else
	echo -e "$upd Updates"
fi
